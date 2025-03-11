import 'package:flutter/material.dart';
import 'subscription_screen.dart';
import 'level_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 360 || screenSize.height < 600;
    final bool isLargeScreen = screenSize.width > 600;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade700,
              Colors.indigo.shade900,
            ],
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
                    padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 20 : 40),
                    child: Text(
                      'Aprende hebreo bíblico de forma divertida',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 30 : 60),
                  Container(
                    width: isSmallScreen ? 150 : (isLargeScreen ? 250 : 200),
                    height: isSmallScreen ? 150 : (isLargeScreen ? 250 : 200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(77), // 0.3 * 255 ≈ 77
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'א ב ג',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 40 : (isLargeScreen ? 80 : 60),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 30 : 60),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LevelSelectionScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 30 : 50, 
                        vertical: isSmallScreen ? 10 : 15
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Comenzar',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 15 : 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SubscriptionScreen()),
                      );
                    },
                    icon: const Icon(Icons.vpn_key, color: Colors.black87),
                    label: Text(
                      'Activar Niveles',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 20 : 30, 
                        vertical: isSmallScreen ? 8 : 12
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 10 : 20),
                  TextButton(
                    onPressed: () {
                      // Mostrar información sobre la aplicación
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Acerca de'),
                            content: SingleChildScrollView(
                              child: Text(
                                'Teolingo te ayudará a aprender las 22 consonantes del alfabeto hebreo bíblico a través de un juego interactivo.\n\n'
                                'Aprenderás a reconocer cada símbolo, su nombre y su transcripción en español.\n\n'
                                'Niveles disponibles:\n'
                                '- Nivel 1: Orden alfabético (gratis)\n'
                                '- Nivel 2: Orden inverso (requiere activación)\n'
                                '- Nivel 3: Orden aleatorio (requiere activación)\n'
                                '- Nivel 4: Nombre a símbolo (requiere activación)\n'
                                '- Nivel 5: Nombre a símbolo inverso (requiere activación)\n'
                                '- Nivel 6: Nombre a símbolo aleatorio (requiere activación)\n'
                                '- Nivel 7: Símbolo a transcripción (requiere activación)',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14 : 16,
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cerrar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Acerca de',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 10 : 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 