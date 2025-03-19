import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import '../providers/bible_course_provider.dart';

class BibleQuestionScreen extends StatefulWidget {
  final int courseIndex;
  final int lessonIndex;

  const BibleQuestionScreen({
    super.key,
    required this.courseIndex,
    required this.lessonIndex,
  });

  @override
  State<BibleQuestionScreen> createState() => _BibleQuestionScreenState();
}

class _BibleQuestionScreenState extends State<BibleQuestionScreen>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<BibleCourseProvider>(context, listen: false);
      provider.startCourse(widget.courseIndex, widget.lessonIndex);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _playSound(bool correct) async {
    try {
      _animationController.reset();
      _animationController.forward();

      await _audioPlayer.setAsset(
        correct ? 'assets/audio/success.mp3' : 'assets/audio/error.mp3',
      );
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Error al reproducir sonido: $e');
    }
  }

  void _showBibleVerseDialog(BuildContext context, String reference) {
    // Textos de ejemplo para versículos (en una aplicación real, estos vendrían de una base de datos)
    Map<String, String> verseTexts = {
      '2 Timoteo 3:16':
          'Toda la Escritura es inspirada por Dios y útil para enseñar, para redargüir, para corregir, para instruir en justicia.',
      'Hebreos 1:1':
          'Dios, habiendo hablado muchas veces y de muchas maneras en otro tiempo a los padres por los profetas.',
      '1 Tesalonicenses 2:13':
          'Por lo cual también nosotros sin cesar damos gracias a Dios, de que cuando recibisteis la palabra de Dios que oísteis de nosotros, la recibisteis no como palabra de hombres, sino según es en verdad, la palabra de Dios, la cual actúa en vosotros los creyentes.',
      'Salmos 119:105':
          'Lámpara es a mis pies tu palabra, y lumbrera a mi camino.',
      'Juan 20:31':
          'Pero estas se han escrito para que creáis que Jesús es el Cristo, el Hijo de Dios, y para que creyendo, tengáis vida en su nombre.',
      'Lucas 24:44-47':
          'Y les dijo: Estas son las palabras que os hablé, estando aún con vosotros: que era necesario que se cumpliese todo lo que está escrito de mí en la ley de Moisés, en los profetas y en los salmos. Entonces les abrió el entendimiento, para que comprendiesen las Escrituras; y les dijo: Así está escrito, y así fue necesario que el Cristo padeciese, y resucitase de los muertos al tercer día; y que se predicase en su nombre el arrepentimiento y el perdón de pecados en todas las naciones, comenzando desde Jerusalén.',
      'Isaías 40:8':
          'Sécase la hierba, marchítase la flor; mas la palabra del Dios nuestro permanece para siempre.',
      'Romanos 15:4':
          'Porque las cosas que se escribieron antes, para nuestra enseñanza se escribieron, a fin de que por la paciencia y la consolación de las Escrituras, tengamos esperanza.',
      '2 Timoteo 3:15-17':
          'Y que desde la niñez has sabido las Sagradas Escrituras, las cuales te pueden hacer sabio para la salvación por la fe que es en Cristo Jesús. Toda la Escritura es inspirada por Dios, y útil para enseñar, para redargüir, para corregir, para instruir en justicia, a fin de que el hombre de Dios sea perfecto, enteramente preparado para toda buena obra.',
      // Versículos faltantes para verdadero/falso
      'Deuteronomio 17:19':
          'Y lo tendrá consigo, y leerá en él todos los días de su vida, para que aprenda a temer a Jehová su Dios, para guardar todas las palabras de esta ley y estos estatutos, para ponerlos por obra.',
      'Deuteronomio 6:6-7':
          'Y estas palabras que yo te mando hoy, estarán sobre tu corazón; y las repetirás a tus hijos, y hablarás de ellas estando en tu casa, y andando por el camino, y al acostarte, y cuando te levantes.',
      'Deuteronomio 11:18-19':
          'Por tanto, pondréis estas mis palabras en vuestro corazón y en vuestra alma, y las ataréis como señal en vuestra mano, y serán por frontales entre vuestros ojos. Y las enseñaréis a vuestros hijos, hablando de ellas cuando te sientes en tu casa, cuando andes por el camino, cuando te acuestes, y cuando te levantes.',
      // Nuevos versículos agregados que estaban faltantes
      'Jeremías 15:16':
          'Fueron halladas tus palabras, y yo las comí; y tu palabra me fue por gozo y por alegría de mi corazón; porque tu nombre se invocó sobre mí, oh Jehová Dios de los ejércitos.',
      'Apocalipsis 1:3':
          'Bienaventurado el que lee, y los que oyen las palabras de esta profecía, y guardan las cosas en ella escritas; porque el tiempo está cerca.',
      'Juan 5:39':
          'Escudriñad las Escrituras; porque a vosotros os parece que en ellas tenéis la vida eterna; y ellas son las que dan testimonio de mí.',
      // Versículos para preguntas verdadero/falso
      'Mateo 4:4':
          'Él respondió y dijo: Escrito está: No sólo de pan vivirá el hombre, sino de toda palabra que sale de la boca de Dios.',
      'Josué 1:8':
          'Nunca se apartará de tu boca este libro de la ley, sino que de día y de noche meditarás en él, para que guardes y hagas conforme a todo lo que en él está escrito; porque entonces harás prosperar tu camino, y todo te saldrá bien.',
      'Proverbios 30:5':
          'Toda palabra de Dios es limpia; él es escudo a los que en él esperan.',
      'Hebreos 4:12':
          'Porque la palabra de Dios es viva y eficaz, y más cortante que toda espada de dos filos; y penetra hasta partir el alma y el espíritu, las coyunturas y los tuétanos, y discierne los pensamientos y las intenciones del corazón.',
      'Juan 17:17': 'Santifícalos en tu verdad; tu palabra es verdad.',
      'Santiago 1:22':
          'Pero sed hacedores de la palabra, y no tan solamente oidores, engañándoos a vosotros mismos.',
      'Salmos 119:11':
          'En mi corazón he guardado tus dichos, para no pecar contra ti.',
      'Salmos 119:160':
          'La suma de tu palabra es verdad, y eterno es todo juicio de tu justicia.',
      '2 Pedro 1:20-21':
          'Entendiendo primero esto, que ninguna profecía de la Escritura es de interpretación privada, porque nunca la profecía fue traída por voluntad humana, sino que los santos hombres de Dios hablaron siendo inspirados por el Espíritu Santo.',
      'Apocalipsis 22:18-19':
          'Yo testifico a todo aquel que oye las palabras de la profecía de este libro: Si alguno añadiere a estas cosas, Dios traerá sobre él las plagas que están escritas en este libro. Y si alguno quitare de las palabras del libro de esta profecía, Dios quitará su parte del libro de la vida, y de la santa ciudad y de las cosas que están escritas en este libro.',
      'Hechos 17:11':
          'Y éstos eran más nobles que los que estaban en Tesalónica, pues recibieron la palabra con toda solicitud, escudriñando cada día las Escrituras para ver si estas cosas eran así.',
      'Mateo 24:35':
          'El cielo y la tierra pasarán, pero mis palabras no pasarán.',
      'Romanos 10:17':
          'Así que la fe es por el oír, y el oír, por la palabra de Dios.',
    };

    // Manejar referencias múltiples (separadas por punto y coma)
    String verseText = '';
    if (reference.contains(';')) {
      // Dividir la referencia en partes
      List<String> references = reference.split(';');

      // Obtener cada versículo
      for (int i = 0; i < references.length; i++) {
        String ref = references[i].trim();
        String verse = verseTexts[ref] ?? 'Versículo no disponible';

        // Agregar el versículo al texto
        verseText += '$ref:\n$verse\n\n';
      }
    } else {
      // Referencia simple
      verseText = verseTexts[reference] ?? 'Versículo no disponible';
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Referencia: $reference',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
            content: SingleChildScrollView(
              child: Text(
                verseText,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }

  void _showFaithCommitmentDialog(BuildContext context) {
    // Estado para manejar los checkboxes
    bool checkPoint1 = false;
    bool checkPoint2 = false;
    bool checkPoint3 = false;

    // Función para verificar si todos los puntos están marcados
    bool allChecked() => checkPoint1 && checkPoint2 && checkPoint3;

    showDialog(
      context: context,
      barrierDismissible: false, // Impedir cerrar tocando fuera del diálogo
      builder: (context) {
        // Usamos StatefulBuilder para poder actualizar el estado de los checkboxes
        return StatefulBuilder(
          builder: (context, setState) {
            return PopScope(
              // Evitar que se cierre con el botón de atrás
              canPop: false,
              child: AlertDialog(
                title: Text(
                  'Compromiso de Fe',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade800,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/animations/bible-heart.json',
                      height: 100,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.menu_book,
                          size: 60,
                          color: Colors.indigo.shade300,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Después de haber leído y entendido, mi decisión personal es:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 16),

                    // Punto 1 con checkbox
                    CheckboxListTile(
                      value: checkPoint1,
                      onChanged: (value) {
                        setState(() {
                          checkPoint1 = value ?? false;
                        });
                      },
                      title: Text(
                        'Creo que la Santa Biblia es revelada por Dios.',
                        style: TextStyle(
                          color: Colors.indigo.shade700,
                          fontSize: 15,
                        ),
                      ),
                      activeColor: Colors.indigo.shade700,
                      checkColor: Colors.white,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                    ),

                    // Punto 2 con checkbox
                    CheckboxListTile(
                      value: checkPoint2,
                      onChanged: (value) {
                        setState(() {
                          checkPoint2 = value ?? false;
                        });
                      },
                      title: Text(
                        'La acepto como regla de fe.',
                        style: TextStyle(
                          color: Colors.indigo.shade700,
                          fontSize: 15,
                        ),
                      ),
                      activeColor: Colors.indigo.shade700,
                      checkColor: Colors.white,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                    ),

                    // Punto 3 con checkbox
                    CheckboxListTile(
                      value: checkPoint3,
                      onChanged: (value) {
                        setState(() {
                          checkPoint3 = value ?? false;
                        });
                      },
                      title: Text(
                        'Decido leerla diariamente.',
                        style: TextStyle(
                          color: Colors.indigo.shade700,
                          fontSize: 15,
                        ),
                      ),
                      activeColor: Colors.indigo.shade700,
                      checkColor: Colors.white,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                actions: [
                  ElevatedButton(
                    onPressed:
                        allChecked()
                            ? () {
                              Navigator.pop(context);
                              // Si vienes de la pantalla de resultados, vuelve a la pantalla anterior
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            }
                            : null, // Deshabilitado si no todos los checkboxes están marcados
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade700,
                      disabledBackgroundColor: Colors.grey.shade400,
                      disabledForegroundColor: Colors.white.withAlpha(25),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 30,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Amén',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
                actionsAlignment: MainAxisAlignment.center,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BibleCourseProvider>(
      builder: (context, provider, child) {
        // Si la lección está completada, mostrar pantalla de resultados
        if (provider.lessonCompleted) {
          return _buildResultsScreen(context, provider);
        }

        // Obtener el tamaño de la pantalla
        final Size screenSize = MediaQuery.of(context).size;
        final bool isSmallScreen =
            screenSize.width < 360 || screenSize.height < 600;

        final question = provider.currentQuestion;
        final options = provider.currentOptions;

        // Calcular el progreso basado en la pregunta actual
        final double progressValue =
            provider.currentQuestionIndex / provider.totalQuestions;

        return Scaffold(
          appBar: AppBar(
            title: Text(provider.currentLesson.title),
            backgroundColor: Colors.indigo.shade800,
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
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
                          const SizedBox(width: 4),
                          Text(
                            '${provider.score}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 14 : 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (provider.streak > 0)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
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
                            const SizedBox(width: 4),
                            Text(
                              '${provider.streak}',
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
                ),
              ),
            ],
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Progreso
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pregunta ${provider.currentQuestionIndex + 1}/${provider.totalQuestions}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Porcentaje de progreso
                            Text(
                              '${(progressValue * 100).toInt()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: progressValue,
                          backgroundColor: Colors.white30,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.green.shade400,
                          ),
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Pregunta
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icono de pregunta
                            Container(
                              width: isSmallScreen ? 50 : 60,
                              height: isSmallScreen ? 50 : 60,
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.help_outline,
                                size: isSmallScreen ? 30 : 40,
                                color: Colors.indigo.shade800,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Texto de la pregunta
                            Text(
                              question.question,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 20 : 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade800,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),

                            // Referencia bíblica con botón para ver el versículo
                            GestureDetector(
                              onTap:
                                  () => _showBibleVerseDialog(
                                    context,
                                    question.bibleReference,
                                  ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade100,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Referencia: ${question.bibleReference}',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 14 : 16,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.amber.shade800,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.visibility,
                                      size: 18,
                                      color: Colors.amber.shade800,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Opciones estilo "Quién quiere ser millonario" en formato 2x2
                    Expanded(
                      child:
                          options.isEmpty
                              ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                              : Column(
                                children: [
                                  // Opciones distribuidas en dos filas
                                  Expanded(
                                    child: Row(
                                      children: [
                                        // Opción A
                                        if (options.isNotEmpty)
                                          Expanded(
                                            child: _buildMillionaireOptionButton(
                                              context,
                                              options[0],
                                              0,
                                              provider.selectedOptionIndex == 0,
                                              provider.isAnswered &&
                                                  provider.correctOptionIndex ==
                                                      0,
                                              provider.isAnswered &&
                                                  provider.selectedOptionIndex ==
                                                      0 &&
                                                  provider.correctOptionIndex !=
                                                      0,
                                              isSmallScreen,
                                              () {
                                                if (!provider.isAnswered) {
                                                  provider.selectOption(0);
                                                  _playSound(
                                                    provider.correctOptionIndex ==
                                                        0,
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        const SizedBox(width: 8),
                                        // Opción B
                                        if (options.length > 1)
                                          Expanded(
                                            child: _buildMillionaireOptionButton(
                                              context,
                                              options[1],
                                              1,
                                              provider.selectedOptionIndex == 1,
                                              provider.isAnswered &&
                                                  provider.correctOptionIndex ==
                                                      1,
                                              provider.isAnswered &&
                                                  provider.selectedOptionIndex ==
                                                      1 &&
                                                  provider.correctOptionIndex !=
                                                      1,
                                              isSmallScreen,
                                              () {
                                                if (!provider.isAnswered) {
                                                  provider.selectOption(1);
                                                  _playSound(
                                                    provider.correctOptionIndex ==
                                                        1,
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Segunda fila (C y D)
                                  Expanded(
                                    child: Row(
                                      children: [
                                        // Opción C
                                        if (options.length > 2)
                                          Expanded(
                                            child: _buildMillionaireOptionButton(
                                              context,
                                              options[2],
                                              2,
                                              provider.selectedOptionIndex == 2,
                                              provider.isAnswered &&
                                                  provider.correctOptionIndex ==
                                                      2,
                                              provider.isAnswered &&
                                                  provider.selectedOptionIndex ==
                                                      2 &&
                                                  provider.correctOptionIndex !=
                                                      2,
                                              isSmallScreen,
                                              () {
                                                if (!provider.isAnswered) {
                                                  provider.selectOption(2);
                                                  _playSound(
                                                    provider.correctOptionIndex ==
                                                        2,
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        const SizedBox(width: 8),
                                        // Opción D
                                        if (options.length > 3)
                                          Expanded(
                                            child: _buildMillionaireOptionButton(
                                              context,
                                              options[3],
                                              3,
                                              provider.selectedOptionIndex == 3,
                                              provider.isAnswered &&
                                                  provider.correctOptionIndex ==
                                                      3,
                                              provider.isAnswered &&
                                                  provider.selectedOptionIndex ==
                                                      3 &&
                                                  provider.correctOptionIndex !=
                                                      3,
                                              isSmallScreen,
                                              () {
                                                if (!provider.isAnswered) {
                                                  provider.selectOption(3);
                                                  _playSound(
                                                    provider.correctOptionIndex ==
                                                        3,
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                    ),

                    // Espacio reservado para el botón "Siguiente Pregunta"
                    // Esto evita el layout shift cuando aparece el botón
                    Container(
                      height: 60,
                      margin: const EdgeInsets.only(top: 16.0),
                      child:
                          provider.isAnswered
                              ? ElevatedButton(
                                onPressed: () {
                                  provider.nextQuestion();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Siguiente Pregunta',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 16 : 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              )
                              : const SizedBox(), // Espacio vacío reservado
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMillionaireOptionButton(
    BuildContext context,
    String text,
    int index,
    bool isSelected,
    bool isCorrect,
    bool isWrong,
    bool isSmallScreen,
    VoidCallback onTap,
  ) {
    // Colores estilo "Quién quiere ser millonario"
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    IconData? iconData;

    if (isCorrect) {
      backgroundColor = Colors.green.shade600;
      borderColor = Colors.green.shade300;
      textColor = Colors.white;
      iconData = Icons.check_circle;
    } else if (isWrong) {
      backgroundColor = Colors.red.shade600;
      borderColor = Colors.red.shade300;
      textColor = Colors.white;
      iconData = Icons.cancel;
    } else if (isSelected) {
      backgroundColor = Colors.blue.shade600;
      borderColor = Colors.blue.shade300;
      textColor = Colors.white;
    } else {
      backgroundColor = Colors.indigo.shade800.withAlpha(25);
      borderColor = Colors.indigo.shade500;
      textColor = Colors.white;
    }

    // Letras para las opciones
    final String optionLetter = String.fromCharCode(
      65 + index,
    ); // A, B, C, D...

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundColor.withAlpha(25), backgroundColor],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Fila con círculo y letra
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: borderColor.withAlpha(25),
                        shape: BoxShape.circle,
                        border: Border.all(color: borderColor, width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          optionLetter,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (iconData != null)
                      Icon(iconData, color: textColor, size: 20),
                  ],
                ),
                const SizedBox(height: 8),
                // Texto de la opción
                Expanded(
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsScreen(
    BuildContext context,
    BibleCourseProvider provider,
  ) {
    // Obtener el tamaño de la pantalla
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen =
        screenSize.width < 360 || screenSize.height < 600;

    // Calcular el porcentaje de aciertos
    final int totalQuestions = provider.totalQuestions;
    final int correctAnswers = provider.completedQuestions.length;
    final double percentage = (correctAnswers / totalQuestions) * 100;

    String message;
    Color messageColor;
    IconData messageIcon;

    if (percentage >= 90) {
      message = '¡Excelente! Tienes un gran conocimiento bíblico';
      messageColor = Colors.green;
      messageIcon = Icons.emoji_events;
    } else if (percentage >= 70) {
      message = '¡Muy bien! Has aprendido la mayoría de los conceptos';
      messageColor = Colors.lightGreen;
      messageIcon = Icons.thumb_up;
    } else if (percentage >= 50) {
      message = 'Buen trabajo. Sigue estudiando la Biblia';
      messageColor = Colors.amber;
      messageIcon = Icons.star;
    } else {
      message = 'Necesitas más estudio bíblico. ¡No te rindas!';
      messageColor = Colors.orange;
      messageIcon = Icons.school;
    }

    return Scaffold(
      extendBodyBehindAppBar: true, // Extender el cuerpo detrás de la AppBar
      extendBody: true, // Extender el cuerpo al final de la pantalla
      backgroundColor: Colors.indigo.shade900, // Color de fondo base
      body: Stack(
        fit: StackFit.expand, // Asegurar que ocupa todo el espacio
        children: [
          // Fondo con gradiente - abarca toda la pantalla
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade700, Colors.indigo.shade900],
              ),
            ),
          ),

          // Animación de confeti superpuesta solo visible si obtuvo más del 50%
          if (percentage >= 50)
            Positioned.fill(
              child: IgnorePointer(
                child: Lottie.asset(
                  'assets/animations/confetti-explosion.json',
                  fit: BoxFit.cover,
                  animate: true,
                  repeat: false,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),

          // Contenido principal con scroll
          ListView(
            padding: EdgeInsets.fromLTRB(16.0, 36.0, 16.0, 24.0),
            children: [
              // Animación de celebración
              SizedBox(
                height: isSmallScreen ? 100 : 120,
                child: Lottie.asset(
                  'assets/animations/confetti.json',
                  fit: BoxFit.contain,
                  animate: true,
                  repeat: true,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      messageIcon,
                      size: isSmallScreen ? 70 : 90,
                      color: Colors.amber,
                    );
                  },
                ),
              ),
              SizedBox(height: 10),

              // Tarjeta de resultados
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        '¡Lección Completada!',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 22 : 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        provider.currentLesson.title,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.indigo.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),

                      // Estadísticas
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            _buildResultItem(
                              'Puntuación',
                              '${provider.score}',
                              Icons.star,
                              Colors.amber,
                            ),
                            const Divider(height: 10),
                            _buildResultItem(
                              'Preguntas Correctas',
                              '$correctAnswers de $totalQuestions',
                              Icons.question_answer,
                              Colors.blue,
                            ),
                            const Divider(height: 10),
                            _buildResultItem(
                              'Porcentaje',
                              '${percentage.toStringAsFixed(0)}%',
                              Icons.pie_chart,
                              Colors.purple,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: messageColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Icon(messageIcon, color: messageColor, size: 22),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                message,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: messageColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Botón de compromiso de fe
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TextButton(
                  onPressed: () {
                    _showFaithCommitmentDialog(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.favorite, color: Colors.white, size: 22),
                      SizedBox(width: 12),
                      Text(
                        'Hacer compromiso de fe',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(
    String label,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0), // Reducido
      child: Row(
        children: [
          Container(
            width: 32, // Reducido
            height: 32, // Reducido
            decoration: BoxDecoration(
              color: iconColor.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 18, // Reducido
            ),
          ),
          const SizedBox(width: 12), // Reducido
          Text(
            label,
            style: TextStyle(
              fontSize: 14, // Reducido
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ), // Reducido
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16, // Reducido
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
