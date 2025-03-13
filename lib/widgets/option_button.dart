import 'package:flutter/material.dart';
import '../providers/game_provider.dart';
import '../providers/language_provider.dart';
import '../models/hebrew_vowel.dart';
import '../models/hebrew_letter.dart';

class OptionButton extends StatelessWidget {
  final dynamic option;
  final int index;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final bool isSmallScreen;
  final VoidCallback onTap;
  final GameLevel? currentLevel;
  final LanguageType languageType;

  const OptionButton({
    super.key,
    required this.option,
    required this.index,
    required this.isSelected,
    required this.isCorrect,
    required this.isWrong,
    this.isSmallScreen = false,
    required this.onTap,
    this.currentLevel,
    required this.languageType,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor = Colors.white;
    IconData? iconData;

    if (isCorrect) {
      backgroundColor = Colors.green;
      iconData = Icons.check_circle;
    } else if (isWrong) {
      backgroundColor = Colors.red;
      iconData = Icons.cancel;
    } else if (isSelected) {
      backgroundColor = Colors.blue.shade700;
    } else {
      backgroundColor = Colors.blue.shade500;
    }

    // Determinar qué mostrar según el nivel y tipo de opción
    String displayText;
    String? subtitleText;

    // Verificar si la opción es una vocal hebrea
    final bool isHebrewVowel = option is HebrewVowel;

    if (currentLevel == GameLevel.level4 ||
        currentLevel == GameLevel.level5 ||
        currentLevel == GameLevel.level6) {
      // Niveles 4, 5, 6: Mostrar el símbolo
      displayText = option.symbol;

      // Para vocales, mostrar un ejemplo con una consonante
      if (isHebrewVowel) {
        subtitleText = 'בּ${option.symbol}';
      }
    } else if (currentLevel == GameLevel.level7) {
      // Nivel 7: Mostrar la transliteración
      displayText =
          option.transliteration.isEmpty ? '-' : option.transliteration;
    } else {
      // Niveles 1, 2, 3: Mostrar el nombre
      displayText = option.name;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51), // 0.2 * 255 ≈ 51
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 4.0 : 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      height:
                          (currentLevel == GameLevel.level4 ||
                                  currentLevel == GameLevel.level5 ||
                                  currentLevel == GameLevel.level6)
                              ? (isSmallScreen ? 30 : 40)
                              : (isSmallScreen ? 25 : 35),
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          displayText,
                          style: TextStyle(
                            fontFamily: 'Times New Roman',
                            color: textColor,
                            fontSize:
                                (currentLevel == GameLevel.level4 ||
                                            currentLevel == GameLevel.level5 ||
                                            currentLevel == GameLevel.level6) &&
                                        !isSmallScreen
                                    ? (isHebrewVowel
                                        ? 28
                                        : 24) // Tamaño más pequeño para evitar desbordamiento
                                    : (isSmallScreen ? 14 : 18),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    // Mostrar subtítulo para vocales si existe
                    if (subtitleText != null)
                      SizedBox(
                        height: isSmallScreen ? 18 : 22,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              subtitleText,
                              style: TextStyle(
                                fontFamily: 'Times New Roman',
                                color: textColor,
                                fontSize: isSmallScreen ? 12 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    // Mostrar valor numérico para los símbolos en niveles 4-6
                    if (!isHebrewVowel &&
                        (currentLevel == GameLevel.level4 ||
                            currentLevel == GameLevel.level5 ||
                            currentLevel == GameLevel.level6) &&
                        option is HebrewLetter &&
                        (option as HebrewLetter).numericValue > 0)
                      SizedBox(
                        height: isSmallScreen ? 12 : 16,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              '(${(option as HebrewLetter).numericValue})',
                              style: TextStyle(
                                color: textColor.withAlpha(25),
                                fontSize: isSmallScreen ? 9 : 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                    // Mostrar tipo de vocal para las vocales
                    if (isHebrewVowel)
                      SizedBox(
                        height: isSmallScreen ? 12 : 16,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              _getVowelTypeText(option),
                              style: TextStyle(
                                color: textColor.withAlpha(25),
                                fontSize: isSmallScreen ? 9 : 11,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (iconData != null)
              Positioned(
                right: isSmallScreen ? 5 : 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Icon(
                    iconData,
                    color: Colors.white,
                    size: isSmallScreen ? 18 : 24,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getVowelTypeText(HebrewVowel vowel) {
    switch (vowel.type) {
      case VowelType.long:
        return 'Larga';
      case VowelType.short:
        return 'Corta';
      case VowelType.semiVowel:
        return vowel.isCompoundShewa ? 'Shewá compuesto' : 'Shewá';
    }
  }
}
