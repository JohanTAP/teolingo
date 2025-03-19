import 'package:flutter/material.dart';
import '../models/bible_lesson.dart';
import '../providers/bible_course_provider.dart';
import 'package:provider/provider.dart';
import 'bible_question_screen.dart';

class BibleLessonsScreen extends StatelessWidget {
  final int courseIndex;
  final BiblicalCourse course;

  const BibleLessonsScreen({
    super.key,
    required this.courseIndex,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen =
        screenSize.width < 360 || screenSize.height < 600;
    final bool isLargeScreen = screenSize.width > 600;

    // Acceder al provider para obtener información sobre las lecciones completadas
    final provider = Provider.of<BibleCourseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
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
          child: Column(
            children: [
              // Encabezado
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(25),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: isSmallScreen ? 40 : 50,
                            height: isSmallScreen ? 40 : 50,
                            decoration: BoxDecoration(
                              color: Colors.amber.shade700,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.menu_book,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lecciones',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 18 : 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Elige una lección para comenzar',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 13 : 15,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withAlpha(25),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${course.lessons.length} lecciones',
                              style: TextStyle(
                                color: Colors.green.shade100,
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 12 : 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Lista de lecciones
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Línea decorativa en la parte superior
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      // Título de la sección
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Todas las lecciones de ${course.title}',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 18 : 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // Lista de lecciones
                      Expanded(
                        child: ListView.builder(
                          itemCount: course.lessons.length,
                          itemBuilder: (context, index) {
                            final lesson = course.lessons[index];
                            // Obtener información sobre si la lección está completada
                            final lessonStatus = provider.getLessonStatus(
                              courseIndex,
                              index,
                            );
                            return _buildLessonCard(
                              context,
                              index,
                              lesson,
                              isSmallScreen,
                              isLargeScreen,
                              lessonStatus,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLessonCard(
    BuildContext context,
    int index,
    BibleLesson lesson,
    bool isSmallScreen,
    bool isLargeScreen,
    LessonStatus? lessonStatus,
  ) {
    // Determinar si la lección está completada y qué trofeo mostrar
    final bool isCompleted = lessonStatus != null;
    final double? percentage = lessonStatus?.percentage;
    String trophyType = '';
    Icon trophyIcon = const Icon(Icons.emoji_events, color: Colors.transparent);

    if (isCompleted && percentage != null) {
      if (percentage >= 90) {
        trophyType = 'Oro';
        trophyIcon = Icon(
          Icons.emoji_events,
          color: Colors.amber.shade700,
          size: 28,
        );
      } else if (percentage >= 70) {
        trophyType = 'Plata';
        trophyIcon = Icon(
          Icons.emoji_events,
          color: Colors.grey.shade400,
          size: 28,
        );
      } else if (percentage >= 50) {
        trophyType = 'Bronce';
        trophyIcon = Icon(
          Icons.emoji_events,
          color: Colors.brown.shade300,
          size: 28,
        );
      } else {
        // Trofeo de hierro para menos de 50%
        trophyType = 'Hierro';
        trophyIcon = Icon(
          Icons.emoji_events,
          color: Colors.blueGrey.shade700,
          size: 28,
        );
      }
    }

    // Determinar el color del borde basado en el porcentaje
    Color? borderColor;
    if (isCompleted && percentage != null) {
      if (percentage >= 90) {
        borderColor = Colors.amber.shade700;
      } else if (percentage >= 70) {
        borderColor = Colors.grey.shade400;
      } else if (percentage >= 50) {
        borderColor = Colors.brown.shade300;
      } else {
        // Borde color hierro para menos de 50%
        borderColor = Colors.blueGrey.shade700;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: isCompleted ? Border.all(color: borderColor!, width: 2) : null,
      ),
      child: Card(
        elevation: 3,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BibleQuestionScreen(
                      courseIndex: courseIndex,
                      lessonIndex: index,
                    ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: Colors.indigo.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lesson.title,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 18 : 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            lesson.description,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 13 : 15,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Mostrar trofeo si la lección está completada
                    if (isCompleted)
                      Tooltip(
                        message: 'Completado con Trofeo de $trophyType',
                        child: trophyIcon,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Contador de preguntas
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.question_answer_outlined,
                            size: 16,
                            color: Colors.blue.shade800,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${lesson.questions.length} preguntas',
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 12 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Si está completada, mostrar porcentaje de aciertos, si no, mostrar botón de comenzar
                    isCompleted
                        ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color:
                                percentage! >= 90
                                    ? Colors.amber.shade100
                                    : percentage >= 70
                                    ? Colors.grey.shade200
                                    : percentage >= 50
                                    ? Colors.brown.shade100
                                    : Colors.blueGrey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${percentage.toInt()}% correcto',
                                style: TextStyle(
                                  color:
                                      percentage >= 90
                                          ? Colors.amber.shade800
                                          : percentage >= 70
                                          ? Colors.grey.shade700
                                          : percentage >= 50
                                          ? Colors.brown.shade800
                                          : Colors.blueGrey.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color:
                                    percentage >= 90
                                        ? Colors.amber.shade800
                                        : percentage >= 70
                                        ? Colors.grey.shade700
                                        : percentage >= 50
                                        ? Colors.brown.shade800
                                        : Colors.blueGrey.shade800,
                              ),
                            ],
                          ),
                        )
                        : Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Comenzar',
                                style: TextStyle(
                                  color: Colors.green.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.play_arrow,
                                size: 16,
                                color: Colors.green.shade800,
                              ),
                            ],
                          ),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
