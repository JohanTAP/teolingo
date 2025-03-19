class BibleQuestion {
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String bibleReference;

  BibleQuestion({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.bibleReference,
  });
}

class BibleLesson {
  final String title;
  final String description;
  final List<BibleQuestion> questions;

  BibleLesson({
    required this.title,
    required this.description,
    required this.questions,
  });
}

class BiblicalCourse {
  final String title;
  final String description;
  final List<BibleLesson> lessons;

  BiblicalCourse({
    required this.title,
    required this.description,
    required this.lessons,
  });
}

// Datos de ejemplo para el curso "Fe de Jesús"
class BiblicalCoursesData {
  static List<BiblicalCourse> courses = [
    BiblicalCourse(
      title: 'Fe de Jesús',
      description: 'Estudio de las doctrinas fundamentales de la Biblia',
      lessons: [
        BibleLesson(
          title: 'REVELADA POR DIOS',
          description: 'La Biblia como palabra inspirada',
          questions: [
            BibleQuestion(
              question: '¿Quién inspiró las Sagradas Escrituras?',
              options: ['Los santos', 'Dios', 'Los hombres', 'No sé'],
              correctOptionIndex: 1,
              bibleReference: '2 Timoteo 3:16',
            ),
            BibleQuestion(
              question: '¿Quiénes recibieron la revelación?',
              options: ['Personas comunes', 'Sabios', 'Profetas', 'No sé'],
              correctOptionIndex: 2,
              bibleReference: 'Hebreos 1:1',
            ),
            BibleQuestion(
              question:
                  '¿Cómo se considera las palabras de los Profetas y Apóstoles?',
              options: [
                'Palabras de hombres',
                'Palabra de sabios',
                'Palabra de Dios',
                'No sé',
              ],
              correctOptionIndex: 2,
              bibleReference: '1 Tesalonicenses 2:13',
            ),
            BibleQuestion(
              question: '¿A qué se compara la Santa Biblia?',
              options: [
                'Una lámpara y luz en el camino',
                'Un tesoro escondido',
                'Un libro de historia',
                'Un conjunto de reglas',
              ],
              correctOptionIndex: 0,
              bibleReference: 'Salmos 119:105',
            ),
            BibleQuestion(
              question:
                  '¿Cuál es la principal razón para haberse escrito la Santa Biblia?',
              options: [
                'Para enseñar historia',
                'Para establecer reglas',
                'Para que creamos que Jesús es el Cristo y tengamos vida',
                'Para entender el pasado',
              ],
              correctOptionIndex: 2,
              bibleReference: 'Juan 20:31',
            ),
            BibleQuestion(
              question:
                  '¿Cuán importante es para Jesús que se entienda la Santa Biblia?',
              options: [
                'No es muy importante',
                'Es opcional entenderla',
                'Es fundamental para la salvación',
                'Solo es importante para los líderes',
              ],
              correctOptionIndex: 2,
              bibleReference: 'Lucas 24:44-47',
            ),
            BibleQuestion(
              question:
                  '¿Cuáles son los beneficios de conocer la Santa Biblia?',
              options: [
                'Solo conocimiento histórico',
                'Sabiduría para la salvación y preparación para toda buena obra',
                'Estatus cultural',
                'Cumplir con requisitos religiosos',
              ],
              correctOptionIndex: 1,
              bibleReference: '2 Timoteo 3:15-17',
            ),
            BibleQuestion(
              question:
                  '¿Qué bendiciones ofrece Dios a los que creen en la Santa Biblia?',
              options: [
                'Riquezas materiales',
                'Prosperidad',
                'Paciencia, consolación y esperanza',
                'Vida sin problemas',
              ],
              correctOptionIndex: 2,
              bibleReference: 'Romanos 15:4',
            ),
            BibleQuestion(
              question:
                  '¿Qué siente al saber cuánto perdurará la Santa Biblia?',
              options: [
                'Indiferencia',
                'Seguridad porque la Palabra de Dios permanece para siempre',
                'Curiosidad',
                'Duda',
              ],
              correctOptionIndex: 1,
              bibleReference: 'Isaías 40:8',
            ),
            BibleQuestion(
              question: 'Estudiar la Biblia todos los días es recomendable.',
              options: ['Verdadero', 'Falso'],
              correctOptionIndex: 0,
              bibleReference: 'Deuteronomio 17:19; Hechos 17:11',
            ),
            BibleQuestion(
              question:
                  'Debemos aceptar los consejos bíblicos con gozo y alegría.',
              options: ['Verdadero', 'Falso'],
              correctOptionIndex: 0,
              bibleReference: 'Jeremías 15:16',
            ),
            BibleQuestion(
              question:
                  'Vivir las enseñanzas bíblicas de forma práctica no es necesario.',
              options: ['Verdadero', 'Falso'],
              correctOptionIndex: 1,
              bibleReference: 'Apocalipsis 1:3',
            ),
            BibleQuestion(
              question:
                  'Debemos meditar y profundizar en la Biblia para conocer cada vez más a Jesús.',
              options: ['Verdadero', 'Falso'],
              correctOptionIndex: 0,
              bibleReference: 'Juan 5:39',
            ),
          ],
        ),
      ],
    ),
  ];
}
