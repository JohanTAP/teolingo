import 'package:flutter/material.dart';
import '../models/hebrew_letter.dart';
import '../providers/game_provider.dart';

class OptionButton extends StatelessWidget {
  final HebrewLetter option;
  final int index;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final bool isSmallScreen;
  final VoidCallback onTap;
  final GameLevel? currentLevel;

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
      displayText = option.transliteration;
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
                child: Text(
                  displayText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: (currentLevel == GameLevel.level4 || 
                              currentLevel == GameLevel.level5 || 
                              currentLevel == GameLevel.level6) && !isSmallScreen
                        ? 24 // Tamaño más grande para los símbolos
                        : (isSmallScreen ? 14 : 18),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
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