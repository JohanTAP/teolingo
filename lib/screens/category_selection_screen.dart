import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../providers/language_provider.dart';
import 'level_selection_screen.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen =
        screenSize.width < 360 || screenSize.height < 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.indigo.shade900],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: isSmallScreen ? 20 : 40),
                  Text(
                    'Selecciona una categoría',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 24 : 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black38,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isSmallScreen ? 20 : 40),
                  Consumer<GameProvider>(
                    builder: (context, gameProvider, child) {
                      // Solo mostrar selección de categoría para hebreo
                      if (gameProvider.currentLanguage != LanguageType.hebrew) {
                        // Si es griego, ir directamente a la selección de niveles
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder:
                                  (context) => const LevelSelectionScreen(),
                            ),
                          );
                        });
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      }

                      return Column(
                        children: [
                          _buildCategoryCard(
                            context,
                            title: 'Consonantes',
                            description:
                                'Aprende las 22 consonantes del alefato hebreo',
                            icon: Icons.text_fields,
                            onTap: () {
                              gameProvider.setHebrewCategory(
                                HebrewCategory.consonants,
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => const LevelSelectionScreen(),
                                ),
                              );
                            },
                            isSelected:
                                gameProvider.currentHebrewCategory ==
                                HebrewCategory.consonants,
                            isSmallScreen: isSmallScreen,
                          ),
                          SizedBox(height: isSmallScreen ? 15 : 25),
                          _buildCategoryCard(
                            context,
                            title: 'Vocales',
                            description:
                                'Aprende los signos vocálicos (niqud) del hebreo',
                            icon: Icons.music_note,
                            onTap: () {
                              gameProvider.setHebrewCategory(
                                HebrewCategory.vowels,
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => const LevelSelectionScreen(),
                                ),
                              );
                            },
                            isSelected:
                                gameProvider.currentHebrewCategory ==
                                HebrewCategory.vowels,
                            isSmallScreen: isSmallScreen,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: isSmallScreen ? 20 : 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 20 : 30,
                        vertical: isSmallScreen ? 10 : 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Volver',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
    required bool isSelected,
    required bool isSmallScreen,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isSmallScreen ? 300 : 400,
        padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade600 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: isSmallScreen ? 30 : 40,
                color:
                    isSelected ? Colors.green.shade600 : Colors.blue.shade800,
              ),
            ),
            SizedBox(width: isSmallScreen ? 10 : 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 5 : 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      color:
                          isSelected
                              ? Colors.white.withAlpha(25)
                              : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: isSmallScreen ? 16 : 20,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
