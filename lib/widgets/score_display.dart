import 'package:flutter/material.dart';

class ScoreDisplay extends StatelessWidget {
  final int score;
  final int streak;
  final bool isSmallScreen;

  const ScoreDisplay({
    super.key,
    required this.score,
    required this.streak,
    this.isSmallScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 8 : 12,
            vertical: isSmallScreen ? 6 : 8,
          ),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.deepOrange,
                size: isSmallScreen ? 16 : 20,
              ),
              SizedBox(width: isSmallScreen ? 3 : 5),
              Text(
                '$score',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: isSmallScreen ? 5 : 10),
        if (streak > 0)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 8 : 12,
              vertical: isSmallScreen ? 6 : 8,
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: Colors.red,
                  size: isSmallScreen ? 16 : 20,
                ),
                SizedBox(width: isSmallScreen ? 3 : 5),
                Text(
                  '$streak',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 14 : 16,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
