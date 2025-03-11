import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int currentIndex;
  final int totalLetters;
  final bool isSmallScreen;

  const ProgressBar({
    super.key,
    required this.currentIndex,
    required this.totalLetters,
    this.isSmallScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    // Calcular el porcentaje de progreso
    // Si currentIndex es 0, el progreso es 0%
    // De lo contrario, es (currentIndex / totalLetters) * 100
    final int progressPercentage = currentIndex == 0 
        ? 0 
        : ((currentIndex / totalLetters) * 100).toInt();
    
    // Calcular el valor para el LinearProgressIndicator
    // Si currentIndex es 0, el valor es 0
    // De lo contrario, es currentIndex / totalLetters
    final double progressValue = currentIndex == 0 
        ? 0 
        : currentIndex / totalLetters;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10.0 : 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Letra ${currentIndex == 0 ? 1 : currentIndex} de $totalLetters',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
              Text(
                '$progressPercentage%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 4 : 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: isSmallScreen ? 6 : 10,
              backgroundColor: Colors.white.withAlpha(77), // 0.3 * 255 ≈ 77
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
} 