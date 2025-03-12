import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LanguageType { hebrew, greek }

class LanguageProvider with ChangeNotifier {
  LanguageType _currentLanguage = LanguageType.hebrew;
  final String _languageKey = 'selected_language';
  bool _isInitialized = false;

  LanguageType get currentLanguage => _currentLanguage;
  bool get isInitialized => _isInitialized;

  // Constructor
  LanguageProvider() {
    _loadLanguagePreference();
  }

  // Cargar la preferencia de idioma guardada
  Future<void> _loadLanguagePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey);

      if (savedLanguage != null) {
        if (savedLanguage == 'greek') {
          _currentLanguage = LanguageType.greek;
        } else {
          _currentLanguage = LanguageType.hebrew;
        }
      }

      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error al cargar preferencia de idioma: $e');
      _isInitialized = true;
      notifyListeners();
    }
  }

  // Cambiar el idioma actual
  Future<void> setLanguage(LanguageType language) async {
    if (_currentLanguage == language) return;

    _currentLanguage = language;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _languageKey,
        language == LanguageType.greek ? 'greek' : 'hebrew',
      );
    } catch (e) {
      debugPrint('Error al guardar preferencia de idioma: $e');
    }
  }

  // Verificar si el idioma actual es hebreo
  bool get isHebrew => _currentLanguage == LanguageType.hebrew;

  // Verificar si el idioma actual es griego
  bool get isGreek => _currentLanguage == LanguageType.greek;

  // Obtener el nombre del idioma actual
  String get languageName =>
      _currentLanguage == LanguageType.hebrew
          ? 'Hebreo Bíblico'
          : 'Griego Bíblico';
}
