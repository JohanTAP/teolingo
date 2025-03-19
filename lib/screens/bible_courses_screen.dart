import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../models/bible_lesson.dart';
import '../providers/bible_course_provider.dart';
import 'bible_lessons_screen.dart';

class BibleCoursesScreen extends StatelessWidget {
  const BibleCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen =
        screenSize.width < 360 || screenSize.height < 600;
    final bool isLargeScreen = screenSize.width > 600;

    // Acceder al provider para obtener información sobre el progreso
    final provider = Provider.of<BibleCourseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos Bíblicos'),
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
              // Encabezado con animación
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: isSmallScreen ? 100 : 130,
                      child: Lottie.asset(
                        'assets/animations/bible-animation.json',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.menu_book,
                            size: isSmallScreen ? 80 : 100,
                            color: Colors.amber,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Cursos Bíblicos',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 28 : 36,
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
                    const SizedBox(height: 8),
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
                          'Aprende conceptos bíblicos de forma interactiva',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                            color: Colors.white,
                            fontFamily: 'Times New Roman',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Lista de cursos
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...BiblicalCoursesData.courses.asMap().entries.map((
                        entry,
                      ) {
                        final index = entry.key;
                        final course = entry.value;

                        // Calcular el progreso del curso
                        int completedLessonsCount = 0;
                        for (int i = 0; i < course.lessons.length; i++) {
                          if (provider.isLessonCompleted(index, i)) {
                            completedLessonsCount++;
                          }
                        }

                        final double courseProgress =
                            course.lessons.isNotEmpty
                                ? completedLessonsCount / course.lessons.length
                                : 0.0;

                        // Comprobar si el curso está en progreso o completado
                        final bool isInProgress =
                            completedLessonsCount > 0 &&
                            completedLessonsCount < course.lessons.length;
                        final bool isCompleted =
                            completedLessonsCount == course.lessons.length &&
                            course.lessons.isNotEmpty;

                        return _buildCourseCard(
                          context,
                          index,
                          course,
                          isSmallScreen,
                          isLargeScreen,
                          courseProgress,
                          isInProgress,
                          isCompleted,
                        );
                      }),

                      // Añadir un botón para futuras actualizaciones
                      const SizedBox(height: 24),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(25),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.update,
                                size: isSmallScreen ? 36 : 48,
                                color: Colors.white70,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Más cursos próximamente",
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14 : 16,
                                  color: Colors.white,
                                  fontFamily: 'Times New Roman',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
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

  Widget _buildCourseCard(
    BuildContext context,
    int index,
    BiblicalCourse course,
    bool isSmallScreen,
    bool isLargeScreen,
    double courseProgress,
    bool isInProgress,
    bool isCompleted,
  ) {
    // Definir colores e iconos según el estado del curso
    Color statusColor = Colors.blue.shade700;
    IconData statusIcon = Icons.play_arrow;
    String statusText = 'Comenzar';

    if (isCompleted) {
      statusColor = Colors.green.shade700;
      statusIcon = Icons.check_circle;
      statusText = 'Completado';
    } else if (isInProgress) {
      statusColor = Colors.orange.shade700;
      statusIcon = Icons.access_time;
      statusText = 'En progreso';
    }

    return Card(
      elevation: 8,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      BibleLessonsScreen(courseIndex: index, course: course),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: isSmallScreen ? 50 : 60,
                        height: isSmallScreen ? 50 : 60,
                        decoration: BoxDecoration(
                          color: Colors.amber.shade700,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.book,
                          color: Colors.white,
                          size: isSmallScreen ? 24 : 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.title,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 20 : 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade800,
                                fontFamily: 'Times New Roman',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              course.description,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 13 : 15,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.indigo.shade800,
                          size: 14,
                        ),
                      ),
                    ],
                  ),

                  if (isInProgress || isCompleted) ...[
                    const SizedBox(height: 12),
                    // Indicador de progreso
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Progreso:',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 13 : 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              '${(courseProgress * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 13 : 14,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: courseProgress,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            statusColor,
                          ),
                          minHeight: 6,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.list_alt,
                              size: isSmallScreen ? 16 : 20,
                              color: Colors.blue.shade700,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${course.lessons.length} lecciones',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 14 : 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Indicador de estado
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              statusIcon,
                              size: isSmallScreen ? 16 : 20,
                              color: statusColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              statusText,
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 14 : 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
