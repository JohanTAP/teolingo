import 'package:flutter/material.dart';
import '../providers/game_provider.dart';
import '../providers/language_provider.dart';

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

    // Determinar qué mostrar según el nivel
    String displayText;
    if (currentLevel == GameLevel.level4 ||
        currentLevel == GameLevel.level5 ||
        currentLevel == GameLevel.level6) {
      // Niveles 4, 5, 6: Mostrar el símbolo
      displayText = option.symbol;
    } else if (currentLevel == GameLevel.level7) {
      // Nivel 7: Mostrar la transliteración (equivalente en español)
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
                  children: [
                    Container(
                      width: double.infinity,
                      height:
                          (currentLevel == GameLevel.level4 ||
                                  currentLevel == GameLevel.level5 ||
                                  currentLevel == GameLevel.level6)
                              ? (isSmallScreen ? 40 : 50)
                              : (isSmallScreen ? 30 : 40),
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
                                    ? 28 // Tamaño más grande para los símbolos
                                    : (isSmallScreen ? 16 : 20),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    // Mostrar valor numérico para los símbolos en niveles 4-6
                    if ((currentLevel == GameLevel.level4 ||
                            currentLevel == GameLevel.level5 ||
                            currentLevel == GameLevel.level6) &&
                        option.numericValue > 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          '(${option.numericValue})',
                          style: TextStyle(
                            color: textColor.withOpacity(0.7),
                            fontSize: isSmallScreen ? 10 : 12,
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
}
