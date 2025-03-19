import 'package:flutter/material.dart';
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

  // Getters para acceder a información actual
  BiblicalCourse get currentCourse => _courses[_currentCourseIndex];
  BibleLesson get currentLesson => currentCourse.lessons[_currentLessonIndex];
  BibleQuestion get currentQuestion =>
      currentLesson.questions[_currentQuestionIndex];
  List<String> get currentOptions => currentQuestion.options;

  // Total de preguntas en la lección actual
  int get totalQuestions => currentLesson.questions.length;

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
  }

  // Obtener el estado de una lección específica
  LessonStatus? getLessonStatus(int courseIndex, int lessonIndex) {
    if (_completedLessons.containsKey(courseIndex)) {
      return _completedLessons[courseIndex]?[lessonIndex];
    }
    return null;
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
}
