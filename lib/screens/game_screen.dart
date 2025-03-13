import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../providers/game_provider.dart';
import '../widgets/option_button.dart';
import '../widgets/progress_bar.dart';
import '../widgets/score_display.dart';
import '../services/audio_service.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

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
            colors: [Colors.blue.shade800, Colors.indigo.shade900],
          ),
        ),
        child: SafeArea(
          child: Consumer<GameProvider>(
            builder: (context, gameProvider, child) {
              if (gameProvider.gameCompleted) {
                return _buildResultsScreen(context, gameProvider);
              }

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 8.0 : 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.home, color: Colors.white),
                          onPressed: () {
                            // Navegar a la pantalla de inicio
                            Navigator.of(context).pop();
                          },
                        ),
                        ScoreDisplay(
                          score: gameProvider.score,
                          streak: gameProvider.streak,
                          isSmallScreen: isSmallScreen,
                        ),
                        Row(
                          children: [
                            // Botón para activar/desactivar pistas
                            IconButton(
                              icon: Icon(
                                gameProvider.showHints
                                    ? Icons.lightbulb
                                    : Icons.lightbulb_outline,
                                color:
                                    gameProvider.showHints
                                        ? Colors.amber
                                        : Colors.white,
                              ),
                              tooltip:
                                  gameProvider.showHints
                                      ? 'Desactivar pistas'
                                      : 'Activar pistas',
                              onPressed: () {
                                gameProvider.toggleHints();
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                gameProvider.resetGame();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ProgressBar(
                    currentIndex: gameProvider.currentIndex,
                    totalLetters: gameProvider.totalLetters,
                    isSmallScreen: isSmallScreen,
                  ),
                  SizedBox(height: isSmallScreen ? 10 : 20),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  constraints.maxHeight -
                                  (isSmallScreen ? 60 : 80),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  gameProvider.currentLevel ==
                                              GameLevel.level4 ||
                                          gameProvider.currentLevel ==
                                              GameLevel.level5 ||
                                          gameProvider.currentLevel ==
                                              GameLevel.level6
                                      ? '¿Cuál es el símbolo de esta letra?'
                                      : (gameProvider.currentLevel ==
                                              GameLevel.level7
                                          ? '¿Cuál es la transcripción de esta letra?'
                                          : '¿Cuál es el nombre de esta letra?'),
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 18 : 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: isSmallScreen ? 15 : 30),
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      width:
                                          isSmallScreen
                                              ? 200
                                              : (isLargeScreen ? 280 : 250),
                                      height:
                                          isSmallScreen
                                              ? 200
                                              : (isLargeScreen ? 280 : 250),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha(77),
                                            blurRadius: 10,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                gameProvider.currentLevel ==
                                                            GameLevel.level4 ||
                                                        gameProvider
                                                                .currentLevel ==
                                                            GameLevel.level5 ||
                                                        gameProvider
                                                                .currentLevel ==
                                                            GameLevel.level6
                                                    ? gameProvider
                                                        .currentLetter
                                                        .name
                                                    : (gameProvider
                                                                .currentLevel ==
                                                            GameLevel.level7
                                                        ? gameProvider
                                                            .currentLetter
                                                            .symbol
                                                        : gameProvider
                                                            .currentLetter
                                                            .symbol),
                                                style: TextStyle(
                                                  fontSize:
                                                      (gameProvider.currentLevel ==
                                                                  GameLevel
                                                                      .level4 ||
                                                              gameProvider
                                                                      .currentLevel ==
                                                                  GameLevel
                                                                      .level5 ||
                                                              gameProvider
                                                                      .currentLevel ==
                                                                  GameLevel
                                                                      .level6)
                                                          ? (isSmallScreen
                                                              ? 30
                                                              : (isLargeScreen
                                                                  ? 50
                                                                  : 40))
                                                          : (isSmallScreen
                                                              ? 80
                                                              : (isLargeScreen
                                                                  ? 120
                                                                  : 100)),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          if (gameProvider.showHints &&
                                              gameProvider.currentLevel !=
                                                  GameLevel.level4 &&
                                              gameProvider.currentLevel !=
                                                  GameLevel.level5 &&
                                              gameProvider.currentLevel !=
                                                  GameLevel.level6)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                              ),
                                              child: Column(
                                                children: [
                                                  if (gameProvider
                                                      .currentLetter
                                                      .transliteration
                                                      .isNotEmpty)
                                                    Text(
                                                      'Trans: ${gameProvider.currentLetter.transliteration}',
                                                      style: TextStyle(
                                                        fontSize:
                                                            isSmallScreen
                                                                ? 12
                                                                : 14,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  if (gameProvider
                                                          .currentLetter
                                                          .numericValue >
                                                      0)
                                                    Text(
                                                      'Valor: ${gameProvider.currentLetter.numericValue}',
                                                      style: TextStyle(
                                                        fontSize:
                                                            isSmallScreen
                                                                ? 12
                                                                : 14,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      bottom: 10,
                                      child: GestureDetector(
                                        onTap: () {
                                          // Reproducir el audio de la letra
                                          AudioService().playAudio(
                                            gameProvider
                                                .currentLetter
                                                .audioPath,
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(
                                            isSmallScreen ? 6 : 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade700,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.volume_up,
                                            color: Colors.white,
                                            size: isSmallScreen ? 20 : 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (gameProvider.currentLetter.isGuttural ||
                                        gameProvider
                                            .currentLetter
                                            .isBegadkephat ||
                                        gameProvider
                                            .currentLetter
                                            .finalForm
                                            .isNotEmpty)
                                      Positioned(
                                        left: 10,
                                        bottom: 10,
                                        child: GestureDetector(
                                          onTap: () {
                                            // Mostrar información adicional
                                            showDialog(
                                              context: context,
                                              builder:
                                                  (context) => AlertDialog(
                                                    title: Text(
                                                      'Información de ${gameProvider.currentLetter.name}',
                                                    ),
                                                    content: SingleChildScrollView(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          if (gameProvider
                                                              .currentLetter
                                                              .isGuttural)
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                    bottom: 8.0,
                                                                  ),
                                                              child: Text(
                                                                '• Letra gutural',
                                                              ),
                                                            ),
                                                          if (gameProvider
                                                              .currentLetter
                                                              .isBegadkephat)
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                    bottom: 8.0,
                                                                  ),
                                                              child: Text(
                                                                '• Letra begadkephat (puede llevar dagesh)',
                                                              ),
                                                            ),
                                                          if (gameProvider
                                                              .currentLetter
                                                              .finalForm
                                                              .isNotEmpty)
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                    bottom: 8.0,
                                                                  ),
                                                              child: Text(
                                                                '• Forma final: ${gameProvider.currentLetter.finalForm}',
                                                              ),
                                                            ),
                                                          if (gameProvider
                                                              .currentLetter
                                                              .notes
                                                              .isNotEmpty)
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets.only(
                                                                    bottom: 8.0,
                                                                  ),
                                                              child: Text(
                                                                '• ${gameProvider.currentLetter.notes}',
                                                              ),
                                                            ),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                  bottom: 8.0,
                                                                  top: 8.0,
                                                                ),
                                                            child: Text(
                                                              'Pronunciación:',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            gameProvider
                                                                .currentLetter
                                                                .pronunciation,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed:
                                                            () =>
                                                                Navigator.of(
                                                                  context,
                                                                ).pop(),
                                                        child: const Text(
                                                          'Cerrar',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                              isSmallScreen ? 6 : 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.amber.shade700,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.info_outline,
                                              color: Colors.white,
                                              size: isSmallScreen ? 20 : 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: isSmallScreen ? 15 : 25),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        isSmallScreen
                                            ? 10
                                            : (isLargeScreen ? 40 : 20),
                                  ),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: isLargeScreen ? 4 : 2,
                                          childAspectRatio:
                                              isSmallScreen
                                                  ? 2.0
                                                  : (isLargeScreen ? 3.0 : 2.5),
                                          crossAxisSpacing:
                                              isSmallScreen ? 8 : 12,
                                          mainAxisSpacing:
                                              isSmallScreen ? 8 : 12,
                                          mainAxisExtent:
                                              (gameProvider.currentLevel ==
                                                          GameLevel.level4 ||
                                                      gameProvider
                                                              .currentLevel ==
                                                          GameLevel.level5 ||
                                                      gameProvider
                                                              .currentLevel ==
                                                          GameLevel.level6)
                                                  ? (isSmallScreen ? 75 : 95)
                                                  : (isSmallScreen ? 65 : 85),
                                        ),
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return OptionButton(
                                        option: gameProvider.options[index],
                                        index: index,
                                        isSelected:
                                            gameProvider.selectedOptionIndex ==
                                            index,
                                        isCorrect:
                                            gameProvider.isAnswered &&
                                            index ==
                                                gameProvider.correctOptionIndex,
                                        isWrong:
                                            gameProvider.isAnswered &&
                                            gameProvider.selectedOptionIndex ==
                                                index &&
                                            index !=
                                                gameProvider.correctOptionIndex,
                                        isSmallScreen: isSmallScreen,
                                        currentLevel: gameProvider.currentLevel,
                                        languageType:
                                            gameProvider.currentLanguage,
                                        onTap: () {
                                          if (!gameProvider.isAnswered) {
                                            gameProvider.selectOption(index);

                                            // Reproducir sonido de éxito o error
                                            if (index ==
                                                gameProvider
                                                    .correctOptionIndex) {
                                              AudioService().playAudio(
                                                'assets/audio/success.mp3',
                                              );
                                            } else {
                                              AudioService().playAudio(
                                                'assets/audio/error.mp3',
                                              );

                                              // Después de un breve retraso, reproducir el audio de la letra correcta
                                              Future.delayed(
                                                const Duration(
                                                  milliseconds: 1000,
                                                ),
                                                () {
                                                  AudioService().playAudio(
                                                    gameProvider
                                                        .currentLetter
                                                        .audioPath,
                                                  );
                                                },
                                              );
                                            }
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: isSmallScreen ? 5 : 10),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: isSmallScreen ? 60 : 80,
                    alignment: Alignment.center,
                    child:
                        gameProvider.isAnswered
                            ? ElevatedButton(
                              onPressed: () {
                                gameProvider.nextQuestion();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 30 : 50,
                                  vertical: isSmallScreen ? 10 : 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Continuar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isSmallScreen ? 16 : 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                            : const SizedBox(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildResultsScreen(BuildContext context, GameProvider gameProvider) {
    // Obtener el tamaño de la pantalla
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen =
        screenSize.width < 360 || screenSize.height < 600;
    final bool isLargeScreen = screenSize.width > 600;

    // Calcular el porcentaje de aciertos
    final int totalLetters = gameProvider.totalLetters;
    final int correctAnswers = gameProvider.completedLetters.length;
    final double percentage = (correctAnswers / totalLetters) * 100;

    String message;
    Color messageColor;

    if (percentage >= 90) {
      message = '¡Excelente! Eres un experto en Teolingo';
      messageColor = Colors.green;
    } else if (percentage >= 70) {
      message = '¡Muy bien! Has aprendido la mayoría de las letras';
      messageColor = Colors.lightGreen;
    } else if (percentage >= 50) {
      message = 'Buen trabajo. Sigue practicando';
      messageColor = Colors.amber;
    } else {
      message = 'Necesitas más práctica. ¡No te rindas!';
      messageColor = Colors.orange;
    }

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animación de confeti si el porcentaje es alto
                if (percentage >= 70)
                  Lottie.asset(
                    'assets/animations/confetti.json',
                    width: isSmallScreen ? 200 : 300,
                    height: isSmallScreen ? 200 : 300,
                    repeat: true,
                    animate: true,
                  ),
                Text(
                  'Resultados',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 28 : 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 10 : 20),
                Container(
                  padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
                  margin: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 15 : 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(51),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Puntuación: ${gameProvider.score}',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 20 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 5 : 10),
                      Text(
                        'Letras aprendidas: $correctAnswers de $totalLetters',
                        style: TextStyle(fontSize: isSmallScreen ? 16 : 18),
                      ),
                      SizedBox(height: isSmallScreen ? 5 : 10),
                      Text(
                        'Porcentaje de aciertos: ${percentage.toInt()}%',
                        style: TextStyle(fontSize: isSmallScreen ? 16 : 18),
                      ),
                      SizedBox(height: isSmallScreen ? 10 : 20),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: messageColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isSmallScreen ? 20 : 30),
                isLargeScreen
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildResultButtons(
                        context,
                        gameProvider,
                        isSmallScreen,
                      ),
                    )
                    : Column(
                      children: [
                        _buildResultButtons(
                          context,
                          gameProvider,
                          isSmallScreen,
                        )[0],
                        SizedBox(height: isSmallScreen ? 10 : 15),
                        _buildResultButtons(
                          context,
                          gameProvider,
                          isSmallScreen,
                        )[1],
                      ],
                    ),
                SizedBox(height: isSmallScreen ? 10 : 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildResultButtons(
    BuildContext context,
    GameProvider gameProvider,
    bool isSmallScreen,
  ) {
    return [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 20 : 30,
            vertical: isSmallScreen ? 10 : 15,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Inicio',
          style: TextStyle(
            color: Colors.white,
            fontSize: isSmallScreen ? 16 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(width: 20),
      ElevatedButton(
        onPressed: () {
          gameProvider.resetGame();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 20 : 30,
            vertical: isSmallScreen ? 10 : 15,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Jugar de nuevo',
          style: TextStyle(
            color: Colors.white,
            fontSize: isSmallScreen ? 16 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
  }
}
