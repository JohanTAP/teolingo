import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'home_screen.dart';

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
                    child: Text(
                      'Selecciona el idioma que deseas aprender',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 20,
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                      ),
                      textAlign: TextAlign.center,
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
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 20 : 40),
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
                      color: Colors.white.withOpacity(0.9),
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
