import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../providers/language_provider.dart';
import 'game_screen.dart';
import 'subscription_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen =
        screenSize.width < 360 || screenSize.height < 600;

    // Obtener el proveedor de idioma
    final languageProvider = Provider.of<LanguageProvider>(context);
    final bool isHebrew = languageProvider.isHebrew;

    // Definir los nombres de la primera y última letra según el idioma
    final String firstLetter = isHebrew ? 'Alef' : 'Alfa';
    final String lastLetter = isHebrew ? 'Tav' : 'Omega';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teolingo - Niveles'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
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
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Selecciona un Nivel',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 24 : 30,
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
                    SizedBox(height: isSmallScreen ? 20 : 30),
                    Consumer<GameProvider>(
                      builder: (context, gameProvider, child) {
                        return Column(
                          children: [
                            _buildLevelCard(
                              context,
                              gameProvider,
                              GameLevel.level1,
                              'Nivel 1: Orden Alfabético',
                              'Aprende las letras en orden alfabético, desde $firstLetter hasta $lastLetter.',
                              Icons.sort_by_alpha,
                              Colors.green,
                              isSmallScreen,
                            ),
                            SizedBox(height: isSmallScreen ? 16 : 24),
                            _buildLevelCard(
                              context,
                              gameProvider,
                              GameLevel.level2,
                              'Nivel 2: Orden Inverso',
                              'Aprende las letras en orden inverso, desde $lastLetter hasta $firstLetter.',
                              Icons.sort,
                              Colors.orange,
                              isSmallScreen,
                            ),
                            SizedBox(height: isSmallScreen ? 16 : 24),
                            _buildLevelCard(
                              context,
                              gameProvider,
                              GameLevel.level3,
                              'Nivel 3: Orden Aleatorio',
                              'Aprende las letras en orden aleatorio para un desafío mayor.',
                              Icons.shuffle,
                              Colors.purple,
                              isSmallScreen,
                            ),
                            SizedBox(height: isSmallScreen ? 16 : 24),
                            _buildLevelCard(
                              context,
                              gameProvider,
                              GameLevel.level4,
                              'Nivel 4: Nombre a Símbolo',
                              'Identifica el símbolo correcto a partir del nombre de la letra.',
                              Icons.translate,
                              Colors.deepPurple,
                              isSmallScreen,
                            ),
                            SizedBox(height: isSmallScreen ? 16 : 24),
                            _buildLevelCard(
                              context,
                              gameProvider,
                              GameLevel.level5,
                              'Nivel 5: Nombre a Símbolo Inverso',
                              'Identifica el símbolo a partir del nombre, en orden inverso.',
                              Icons.sort,
                              Colors.indigo,
                              isSmallScreen,
                            ),
                            SizedBox(height: isSmallScreen ? 16 : 24),
                            _buildLevelCard(
                              context,
                              gameProvider,
                              GameLevel.level6,
                              'Nivel 6: Nombre a Símbolo Aleatorio',
                              'Identifica el símbolo a partir del nombre, en orden aleatorio.',
                              Icons.shuffle,
                              Colors.deepOrange,
                              isSmallScreen,
                            ),
                            SizedBox(height: isSmallScreen ? 16 : 24),
                            _buildLevelCard(
                              context,
                              gameProvider,
                              GameLevel.level7,
                              'Nivel 7: Símbolo a Transcripción',
                              'Identifica la transcripción en español a partir del símbolo de la letra.',
                              Icons.translate,
                              Colors.teal,
                              isSmallScreen,
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 30),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SubscriptionScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.vpn_key),
                      label: const Text(
                        'Activar Niveles Adicionales',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard(
    BuildContext context,
    GameProvider gameProvider,
    GameLevel level,
    String title,
    String description,
    IconData icon,
    Color color,
    bool isSmallScreen,
  ) {
    final bool isUnlocked = gameProvider.isLevelUnlocked(level);
    final Color cardColor = isUnlocked ? Colors.white : Colors.grey.shade300;
    final Color iconBgColor = isUnlocked ? color : Colors.grey.shade600;
    final Color textColor = isUnlocked ? Colors.black87 : Colors.grey.shade700;
    final Color descriptionColor =
        isUnlocked ? Colors.black54 : Colors.grey.shade600;
    final Color statusColor = isUnlocked ? color : Colors.grey.shade600;

    return Card(
      elevation: isUnlocked ? 8 : 4,
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap:
            isUnlocked
                ? () {
                  gameProvider.setLevel(level);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GameScreen()),
                  );
                }
                : () {
                  _showSubscriptionDialog(context);
                },
        borderRadius: BorderRadius.circular(16),
        child: Opacity(
          opacity: isUnlocked ? 1.0 : 0.8,
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
            child: Row(
              children: [
                Container(
                  width: isSmallScreen ? 50 : 60,
                  height: isSmallScreen ? 50 : 60,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isUnlocked ? icon : Icons.lock,
                    color: Colors.white,
                    size: isSmallScreen ? 24 : 30,
                  ),
                ),
                SizedBox(width: isSmallScreen ? 12 : 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 4 : 8),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 14,
                          color: descriptionColor,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      Text(
                        isUnlocked ? 'Toca para comenzar' : 'Nivel bloqueado',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 14,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nivel Bloqueado'),
          content: const Text(
            'Este nivel requiere activación. ¿Deseas activar los niveles adicionales ahora?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SubscriptionScreen(),
                  ),
                );
              },
              child: const Text('Activar'),
            ),
          ],
        );
      },
    );
  }
}
