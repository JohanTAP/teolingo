import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/bible_lesson.dart';

// Clase para almacenar el estado de una lección
class LessonStatus {
  final bool completed;
  final double percentage;
  final int score;

  LessonStatus({
    required this.completed,
    required this.percentage,
    required this.score,
  });

  // Convertir a Map para guardar en SharedPreferences
  Map<String, dynamic> toJson() {
    return {'completed': completed, 'percentage': percentage, 'score': score};
  }

  // Crear desde un Map
  factory LessonStatus.fromJson(Map<String, dynamic> json) {
    return LessonStatus(
      completed: json['completed'] ?? false,
      percentage: json['percentage'] ?? 0.0,
      score: json['score'] ?? 0,
    );
  }
}

class BibleCourseProvider with ChangeNotifier {
  // Estado actual del juego
  int _currentLessonIndex = 0;
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _streak = 0;
  bool _isAnswered = false;
  int? _selectedOptionIndex;
  int? _correctOptionIndex;
  bool _lessonCompleted = false;
  List<int> _completedQuestions = [];
  final List<BiblicalCourse> _courses = BiblicalCoursesData.courses;
  int _currentCourseIndex = 0;

  // Almacena el estado de las lecciones completadas
  // Map<courseIndex, Map<lessonIndex, LessonStatus>>
  final Map<int, Map<int, LessonStatus>> _completedLessons = {};

  // Clave para guardar en SharedPreferences
  final String _prefsKey = 'bible_course_progress';

  // Estado de inicialización
  bool _initialized = false;

  // Constructor
  BibleCourseProvider() {
    _initializeProvider();
  }

  // Inicializar el provider asíncronamente
  Future<void> _initializeProvider() async {
    await _loadProgress();
    _initialized = true;
    notifyListeners();
  }

  // Getters
  int get currentLessonIndex => _currentLessonIndex;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int get streak => _streak;
  bool get isAnswered => _isAnswered;
  int? get selectedOptionIndex => _selectedOptionIndex;
  int? get correctOptionIndex => _correctOptionIndex;
  bool get lessonCompleted => _lessonCompleted;
  List<int> get completedQuestions => _completedQuestions;
  List<BiblicalCourse> get courses => _courses;
  int get currentCourseIndex => _currentCourseIndex;
  Map<int, Map<int, LessonStatus>> get completedLessons => _completedLessons;
  bool get initialized => _initialized;

  // Getters para acceder a información actual
  BiblicalCourse get currentCourse => _courses[_currentCourseIndex];
  BibleLesson get currentLesson => currentCourse.lessons[_currentLessonIndex];
  BibleQuestion get currentQuestion =>
      currentLesson.questions[_currentQuestionIndex];
  List<String> get currentOptions => currentQuestion.options;

  // Total de preguntas en la lección actual
  int get totalQuestions => currentLesson.questions.length;

  // Cargar progreso desde SharedPreferences
  Future<void> _loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonData = prefs.getString(_prefsKey);

      if (jsonData != null && jsonData.isNotEmpty) {
        // Convertir el JSON string a Map
        final Map<String, dynamic> data = _parseJsonMap(jsonData);

        // Recorrer los cursos
        data.forEach((courseKey, courseLessons) {
          final int courseIndex = int.parse(courseKey);
          _completedLessons[courseIndex] = {};

          // Recorrer las lecciones de cada curso
          if (courseLessons is Map) {
            (courseLessons).forEach((lessonKey, lessonData) {
              final int lessonIndex = int.parse(lessonKey);

              if (lessonData is Map<String, dynamic>) {
                _completedLessons[courseIndex]![lessonIndex] =
                    LessonStatus.fromJson(lessonData);
              }
            });
          }
        });
        debugPrint(
          '🔄 Progreso cargado correctamente: ${_completedLessons.length} cursos con progreso',
        );
        // Mostrar el detalle de las lecciones completadas para debugging
        _completedLessons.forEach((courseIndex, lessons) {
          lessons.forEach((lessonIndex, status) {
            debugPrint(
              '📚 Curso $courseIndex, Lección $lessonIndex: ${status.percentage.toStringAsFixed(0)}% completado',
            );
          });
        });
      } else {
        debugPrint('⚠️ No se encontró progreso guardado');
      }
    } catch (e) {
      debugPrint('❌ Error al cargar progreso: $e');
    }
  }

  // Parsear el JSON string a Map
  Map<String, dynamic> _parseJsonMap(String jsonString) {
    try {
      return json.decode(jsonString);
    } catch (e) {
      debugPrint('❌ Error al parsear JSON: $e');
      return {};
    }
  }

  // Guardar progreso en SharedPreferences
  Future<void> _saveProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Convertir el mapa de lecciones completadas a un formato compatible con SharedPreferences
      final Map<String, dynamic> data = {};

      _completedLessons.forEach((courseIndex, lessons) {
        final Map<String, dynamic> courseLessons = {};

        lessons.forEach((lessonIndex, status) {
          courseLessons[lessonIndex.toString()] = status.toJson();
        });

        data[courseIndex.toString()] = courseLessons;
      });

      // Convertir a JSON y guardar
      final String jsonData = json.encode(data);
      await prefs.setString(_prefsKey, jsonData);
      debugPrint(
        '💾 Progreso guardado correctamente: ${_completedLessons.length} cursos',
      );

      // Verificar inmediatamente que el progreso se guardó
      final String? savedData = prefs.getString(_prefsKey);
      if (savedData != null && savedData.isNotEmpty) {
        debugPrint(
          '✅ Verificación: progreso guardado con éxito (${savedData.length} bytes)',
        );
      } else {
        debugPrint('⚠️ Advertencia: no se pudo verificar el progreso guardado');
      }
    } catch (e) {
      debugPrint('❌ Error al guardar progreso: $e');
    }
  }

  // Inicializar el curso
  void startCourse(int courseIndex, int lessonIndex) {
    _currentCourseIndex = courseIndex;
    _currentLessonIndex = lessonIndex;
    _currentQuestionIndex = 0;
    _score = 0;
    _streak = 0;
    _isAnswered = false;
    _selectedOptionIndex = null;
    _correctOptionIndex = null;
    _lessonCompleted = false;
    _completedQuestions = [];

    // Cargar progreso existente si existe
    final lessonStatus = getLessonStatus(courseIndex, lessonIndex);
    if (lessonStatus != null) {
      debugPrint(
        '📋 Cargando estado existente para Curso $courseIndex, Lección $lessonIndex',
      );
      // Opcionalmente podrías restaurar el puntaje anterior
      // _score = lessonStatus.score;
    }

    // Configurar la respuesta correcta para la primera pregunta
    _correctOptionIndex = currentQuestion.correctOptionIndex;

    notifyListeners();
  }

  // Seleccionar una opción de respuesta
  void selectOption(int index) {
    if (_isAnswered) return;

    _selectedOptionIndex = index;
    _isAnswered = true;
    _correctOptionIndex = currentQuestion.correctOptionIndex;

    if (index == _correctOptionIndex) {
      _score += 10 + (_streak * 2);
      _streak++;

      if (!_completedQuestions.contains(_currentQuestionIndex)) {
        _completedQuestions.add(_currentQuestionIndex);
      }
    } else {
      _streak = 0;
    }

    notifyListeners();
  }

  // Avanzar a la siguiente pregunta
  void nextQuestion() {
    // Verificar si hemos llegado al final de las preguntas
    if (_currentQuestionIndex < totalQuestions - 1) {
      _currentQuestionIndex++;
    } else {
      // Si llegamos al final, marcar la lección como completada
      _lessonCompleted = true;

      // Guardar el estado de la lección completada
      _saveLessonStatus();

      notifyListeners();
      return;
    }

    _isAnswered = false;
    _selectedOptionIndex = null;
    _correctOptionIndex = currentQuestion.correctOptionIndex;

    notifyListeners();
  }

  // Guardar el estado de la lección completada
  void _saveLessonStatus() {
    // Calcular el porcentaje de aciertos
    final double percentage =
        (_completedQuestions.length / totalQuestions) * 100;

    // Crear el objeto LessonStatus
    final LessonStatus status = LessonStatus(
      completed: true,
      percentage: percentage,
      score: _score,
    );

    // Inicializar el mapa para el curso si no existe
    _completedLessons[_currentCourseIndex] ??= {};

    // Guardar el estado de la lección
    _completedLessons[_currentCourseIndex]![_currentLessonIndex] = status;

    // Guardar el progreso de forma persistente
    _saveProgress();

    debugPrint(
      '🏆 Lección completada y guardada: Curso $_currentCourseIndex, Lección $_currentLessonIndex, Porcentaje: ${percentage.toStringAsFixed(0)}%',
    );
  }

  // Obtener el estado de una lección específica
  LessonStatus? getLessonStatus(int courseIndex, int lessonIndex) {
    if (_completedLessons.containsKey(courseIndex)) {
      return _completedLessons[courseIndex]?[lessonIndex];
    }
    return null;
  }

  // Verificar si una lección está disponible para jugar (desbloqueada)
  bool isLessonAvailable(int courseIndex, int lessonIndex) {
    // La primera lección siempre está disponible
    if (lessonIndex == 0) return true;

    // Para las demás lecciones, verificar si la anterior está completada
    final bool available = isLessonCompleted(courseIndex, lessonIndex - 1);

    // Log para debugging
    if (lessonIndex > 0) {
      debugPrint(
        '🔍 Verificando disponibilidad: Curso $courseIndex, Lección $lessonIndex - ${available ? "Disponible ✅" : "Bloqueada 🔒"}',
      );
    }

    return available;
  }

  // Verificar si una lección está completada
  bool isLessonCompleted(int courseIndex, int lessonIndex) {
    final status = getLessonStatus(courseIndex, lessonIndex);
    return status?.completed ?? false;
  }

  // Reiniciar la lección actual
  void resetLesson() {
    _currentQuestionIndex = 0;
    _score = 0;
    _streak = 0;
    _isAnswered = false;
    _selectedOptionIndex = null;
    _correctOptionIndex = currentQuestion.correctOptionIndex;
    _lessonCompleted = false;
    _completedQuestions = [];

    notifyListeners();
  }

  // Borrar todo el progreso (para pruebas)
  Future<void> clearAllProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsKey);
      _completedLessons.clear();
      debugPrint('🗑️ Todo el progreso ha sido borrado');
      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error al borrar progreso: $e');
    }
  }
}
