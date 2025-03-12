import 'dart:math';
import 'package:flutter/material.dart';
import '../models/hebrew_letter.dart';
import '../services/subscription_service.dart';
import '../utils/key_generator.dart';

enum GameLevel {
  level1, // Orden normal (de principio a fin)
  level2, // Orden inverso (de fin a principio)
  level3, // Orden aleatorio
  level4, // Nombre a símbolo (se muestra el nombre y hay que seleccionar el símbolo)
  level5, // Nombre a símbolo - Orden inverso (de fin a principio)
  level6, // Nombre a símbolo - Orden aleatorio
  level7, // Símbolo a nombre (se muestra el símbolo y hay que seleccionar el nombre)
}

class GameProvider with ChangeNotifier {
  int _currentIndex = 0;
  int _score = 0;
  int _streak = 0;
  bool _isAnswered = false;
  int? _selectedOptionIndex;
  int? _correctOptionIndex;
  List<HebrewLetter> _options = [];
  bool _gameCompleted = false;
  List<int> _completedLetters = [];
  GameLevel _currentLevel = GameLevel.level1;
  List<int> _levelSequence = [];
  final SubscriptionService _subscriptionService = SubscriptionService();
  bool _isSubscriptionChecked = false;
  int _maxUnlockedLevel = 1;

  // Getters
  int get currentIndex => _currentIndex;
  int get score => _score;
  int get streak => _streak;
  bool get isAnswered => _isAnswered;
  int? get selectedOptionIndex => _selectedOptionIndex;
  int? get correctOptionIndex => _correctOptionIndex;
  List<HebrewLetter> get options => _options;
  bool get gameCompleted => _gameCompleted;
  List<int> get completedLetters => _completedLetters;
  GameLevel get currentLevel => _currentLevel;
  int get maxUnlockedLevel => _maxUnlockedLevel;

  HebrewLetter get currentLetter {
    final int letterIndex = _levelSequence[_currentIndex];
    return HebrewLettersData.letters[letterIndex];
  }

  GameProvider() {
    _initializeGame();
  }

  Future<void> _initializeGame() async {
    try {
      debugPrint('Inicializando juego...');
      await _checkSubscription();
      _setLevelSequence();
      _generateOptions();
      debugPrint('Juego inicializado correctamente');
    } catch (e) {
      debugPrint('Error al inicializar juego: $e');
    }
  }

  Future<void> _checkSubscription() async {
    try {
      if (_isSubscriptionChecked) {
        debugPrint(
          'Suscripción ya verificada, nivel actual: $_maxUnlockedLevel',
        );
        return;
      }

      debugPrint('Verificando nivel desbloqueado...');
      final int previousLevel = _maxUnlockedLevel;
      _maxUnlockedLevel = await _subscriptionService.getUnlockedLevel();
      debugPrint(
        'Nivel máximo desbloqueado: $_maxUnlockedLevel (anterior: $previousLevel)',
      );

      // Si el nivel ha cambiado, notificar a los listeners
      if (_maxUnlockedLevel != previousLevel) {
        debugPrint('El nivel ha cambiado, notificando a los listeners');
        notifyListeners();
      }

      _isSubscriptionChecked = true;
    } catch (e) {
      debugPrint('Error al verificar suscripción: $e');
      // En caso de error, asumimos que solo el nivel 1 está desbloqueado
      _maxUnlockedLevel = 1;
      _isSubscriptionChecked = true;
      notifyListeners();
    }
  }

  void _setLevelSequence() {
    try {
      final int totalLetters = HebrewLettersData.letters.length;
      debugPrint('Configurando secuencia para nivel: $_currentLevel');

      switch (_currentLevel) {
        case GameLevel.level1:
          // Orden normal: 0, 1, 2, ..., 21
          _levelSequence = List.generate(totalLetters, (index) => index);
          debugPrint(
            'Secuencia nivel 1 (normal): ${_levelSequence.length} letras',
          );
          break;
        case GameLevel.level2:
          // Orden inverso: 21, 20, 19, ..., 0
          _levelSequence = List.generate(
            totalLetters,
            (index) => totalLetters - 1 - index,
          );
          debugPrint(
            'Secuencia nivel 2 (inverso): ${_levelSequence.length} letras',
          );
          break;
        case GameLevel.level3:
          // Orden aleatorio
          _levelSequence = List.generate(totalLetters, (index) => index);
          _levelSequence.shuffle();
          debugPrint(
            'Secuencia nivel 3 (aleatorio): ${_levelSequence.length} letras',
          );
          break;
        case GameLevel.level4:
          // Nombre a símbolo: mismo orden que nivel 1 pero diferente presentación
          _levelSequence = List.generate(totalLetters, (index) => index);
          debugPrint(
            'Secuencia nivel 4 (nombre a símbolo): ${_levelSequence.length} letras',
          );
          break;
        case GameLevel.level5:
          // Nombre a símbolo - Orden inverso (de fin a principio)
          _levelSequence = List.generate(
            totalLetters,
            (index) => totalLetters - 1 - index,
          );
          debugPrint(
            'Secuencia nivel 5 (nombre a símbolo - orden inverso): ${_levelSequence.length} letras',
          );
          break;
        case GameLevel.level6:
          // Nombre a símbolo - Orden aleatorio
          _levelSequence = List.generate(totalLetters, (index) => index);
          _levelSequence.shuffle();
          debugPrint(
            'Secuencia nivel 6 (nombre a símbolo - orden aleatorio): ${_levelSequence.length} letras',
          );
          break;
        case GameLevel.level7:
          // Símbolo a nombre: mismo orden que nivel 1 pero diferente presentación
          _levelSequence = List.generate(totalLetters, (index) => index);
          debugPrint(
            'Secuencia nivel 7 (símbolo a nombre): ${_levelSequence.length} letras',
          );
          break;
      }

      _currentIndex = 0;
    } catch (e) {
      debugPrint('Error al configurar secuencia de nivel: $e');
      // En caso de error, usamos el nivel 1 (orden normal)
      final int totalLetters = HebrewLettersData.letters.length;
      _levelSequence = List.generate(totalLetters, (index) => index);
      _currentIndex = 0;
    }
  }

  void _generateOptions() {
    try {
      final random = Random();
      _correctOptionIndex = random.nextInt(4);
      final int currentLetterIndex = _levelSequence[_currentIndex];

      _options = List.generate(4, (index) {
        if (index == _correctOptionIndex) {
          return HebrewLettersData.letters[currentLetterIndex];
        } else {
          int randomIndex;
          do {
            randomIndex = random.nextInt(HebrewLettersData.letters.length);
          } while (randomIndex == currentLetterIndex ||
              _options.any(
                (option) =>
                    option.symbol ==
                    HebrewLettersData.letters[randomIndex].symbol,
              ));

          return HebrewLettersData.letters[randomIndex];
        }
      });
    } catch (e) {
      debugPrint('Error al generar opciones: $e');
      // En caso de error, generamos opciones básicas
      _correctOptionIndex = 0;
      _options = List.generate(4, (index) => HebrewLettersData.letters[index]);
    }
  }

  void selectOption(int index) {
    if (_isAnswered) return;

    _selectedOptionIndex = index;
    _isAnswered = true;

    if (index == _correctOptionIndex) {
      _score += 10 + (_streak * 2);
      _streak++;

      final int currentLetterIndex = _levelSequence[_currentIndex];
      if (!_completedLetters.contains(currentLetterIndex)) {
        _completedLetters.add(currentLetterIndex);
      }
    } else {
      _streak = 0;
    }

    notifyListeners();
  }

  void nextQuestion() {
    // Verificar si hemos llegado al final de la secuencia
    if (_currentIndex < _levelSequence.length - 1) {
      _currentIndex++;
    } else {
      // Si llegamos al final de la secuencia, marcar el juego como completado
      _gameCompleted = true;
      notifyListeners();
      return;
    }

    _isAnswered = false;
    _selectedOptionIndex = null;
    _generateOptions();

    notifyListeners();
  }

  void resetGame() {
    _currentIndex = 0;
    _score = 0;
    _streak = 0;
    _isAnswered = false;
    _selectedOptionIndex = null;
    _gameCompleted = false;
    _completedLetters = [];
    _setLevelSequence();
    _generateOptions();
    notifyListeners();
  }

  Future<void> setLevel(GameLevel level) async {
    try {
      // Verificar si el nivel está desbloqueado
      final int levelNumber = level.index + 1;
      debugPrint('Intentando cambiar al nivel $levelNumber');

      final bool isUnlocked = await _subscriptionService.isLevelUnlocked(
        levelNumber,
      );

      if (!isUnlocked) {
        debugPrint('Nivel $levelNumber no está desbloqueado');
        return; // No cambiar el nivel si no está desbloqueado
      }

      debugPrint('Cambiando al nivel $levelNumber');
      _currentLevel = level;
      resetGame();
    } catch (e) {
      debugPrint('Error al cambiar de nivel: $e');
    }
  }

  Future<bool> activateSubscription(String key) async {
    try {
      debugPrint('Activando suscripción con clave: $key');

      // Verificar formato de la clave
      if (!KeyGenerator.isValidKeyFormat(key)) {
        debugPrint('Formato de clave inválido');
        return false;
      }

      // Obtener el nivel de la clave antes de activar
      final int keyLevel = KeyGenerator.getLevelFromKey(key);
      debugPrint('Nivel de la clave antes de activar: $keyLevel');

      final bool success = await _subscriptionService.activateSubscription(key);

      if (success) {
        debugPrint(
          'Suscripción activada correctamente, actualizando nivel desbloqueado',
        );
        // Forzar la recarga del nivel desbloqueado
        _isSubscriptionChecked = false;
        await _checkSubscription();

        // Verificar que el nivel se haya actualizado correctamente
        debugPrint(
          'Nivel máximo desbloqueado después de activar: $_maxUnlockedLevel',
        );

        return true;
      } else {
        debugPrint('Error al activar suscripción');
        return false;
      }
    } catch (e) {
      debugPrint('Excepción al activar suscripción: $e');
      return false;
    }
  }

  bool isLevelUnlocked(GameLevel level) {
    final int levelNumber = level.index + 1;
    final bool isUnlocked = levelNumber <= _maxUnlockedLevel;
    debugPrint(
      'Verificando si nivel $levelNumber está desbloqueado: $isUnlocked',
    );
    return isUnlocked;
  }
}
