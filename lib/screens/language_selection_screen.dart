import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'home_screen.dart';
import 'bible_courses_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen =
        screenSize.width < 360 || screenSize.height < 600;
    final bool isLargeScreen = screenSize.width > 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade700, Colors.indigo.shade900],
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
                    'Teolingo',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 30 : (isLargeScreen ? 50 : 40),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
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
                  SizedBox(height: isSmallScreen ? 10 : 20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 20 : 40,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Selecciona que deseas aprender',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 20,
                          color: Colors.white,
                          fontFamily: 'Times New Roman',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 30 : 50),
                  _buildLanguageOption(
                    context,
                    'Hebreo Bíblico',
                    'Aprende el alefbeto hebreo y sus sonidos',
                    Icons.language,
                    Colors.amber.shade700,
                    LanguageType.hebrew,
                    isSmallScreen,
                    isLargeScreen,
                  ),
                  SizedBox(height: isSmallScreen ? 20 : 30),
                  _buildLanguageOption(
                    context,
                    'Griego Bíblico',
                    'Aprende el alfabeto griego y sus sonidos',
                    Icons.language,
                    Colors.teal.shade600,
                    LanguageType.greek,
                    isSmallScreen,
                    isLargeScreen,
                  ),
                  SizedBox(height: isSmallScreen ? 20 : 30),
                  _buildBiblicalCoursesOption(
                    context,
                    'Cursos Bíblicos',
                    'Estudia temas bíblicos de forma interactiva',
                    Icons.menu_book,
                    Colors.purple.shade700,
                    isSmallScreen,
                    isLargeScreen,
                  ),
                  SizedBox(height: isSmallScreen ? 30 : 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    LanguageType language,
    bool isSmallScreen,
    bool isLargeScreen,
  ) {
    // Calcular el ancho del botón basado en el tamaño de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth =
        isLargeScreen
            ? screenWidth * 0.6
            : (isSmallScreen ? screenWidth * 0.85 : screenWidth * 0.75);

    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: () {
          // Establecer el idioma seleccionado
          Provider.of<LanguageProvider>(
            context,
            listen: false,
          ).setLanguage(language);

          // Navegar a la pantalla principal
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(
            vertical: isSmallScreen ? 15 : 20,
            horizontal: isSmallScreen ? 20 : 30,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: isSmallScreen ? 30 : 40),
            SizedBox(width: isSmallScreen ? 15 : 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 5 : 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildBiblicalCoursesOption(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    bool isSmallScreen,
    bool isLargeScreen,
  ) {
    // Calcular el ancho del botón basado en el tamaño de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth =
        isLargeScreen
            ? screenWidth * 0.6
            : (isSmallScreen ? screenWidth * 0.85 : screenWidth * 0.75);

    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: () {
          // Navegar directamente a la pantalla de cursos bíblicos
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BibleCoursesScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(
            vertical: isSmallScreen ? 15 : 20,
            horizontal: isSmallScreen ? 20 : 30,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: isSmallScreen ? 30 : 40),
            SizedBox(width: isSmallScreen ? 15 : 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 5 : 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
