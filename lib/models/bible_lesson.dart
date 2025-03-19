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
        BibleLesson(
          title: 'DIOS',
          description: 'Conociendo la naturaleza y el carácter de Dios',
          questions: [
            BibleQuestion(
              question: '¿Cuántos dioses hay?',
              options: ['Tres', 'Uno', 'Ninguno', 'No sé'],
              correctOptionIndex: 1,
              bibleReference: 'Efesios 4:6',
            ),
            BibleQuestion(
              question: '¿Cuál es la naturaleza de Dios?',
              options: ['Sin materia', 'Carnal', 'Espiritual', 'No sé'],
              correctOptionIndex: 2,
              bibleReference: 'Juan 4:24',
            ),
            BibleQuestion(
              question: '¿Cuáles son las tres personas de la Deidad?',
              options: [
                'Padre, Hijo, Espíritu',
                'Padre, Madre, Hijo',
                'Padre e Hijo',
                'No sé',
              ],
              correctOptionIndex: 0,
              bibleReference: 'Mateo 28:19',
            ),
            BibleQuestion(
              question: '¿Cómo es el carácter de Dios?',
              options: ['Firme, tirano', 'Amor', 'Indiferente', 'No sé'],
              correctOptionIndex: 1,
              bibleReference: '1 Juan 4:8',
            ),
            BibleQuestion(
              question:
                  '¿Cómo considera Dios al ser humano? ¿Qué siente al respecto?',
              options: [
                'Con indiferencia',
                'Como enemigos',
                'Como sus hijos, con amor paternal',
                'Como siervos solamente',
              ],
              correctOptionIndex: 2,
              bibleReference: '1 Juan 3:1, 2',
            ),
            BibleQuestion(
              question: 'Dios ¿se preocupa por nuestros problemas?',
              options: [
                'No, estamos solos',
                'Sí, escucha nuestro clamor y nos ayuda',
                'Solo se preocupa por cosas importantes',
                'No tiene tiempo para todos',
              ],
              correctOptionIndex: 1,
              bibleReference: 'Salmos 40:1-3',
            ),
            BibleQuestion(
              question:
                  '¿De qué manera el ser humano puede percibir el amor de Dios?',
              options: [
                'A través de la naturaleza solamente',
                'En el envío de su Hijo para salvarnos',
                'En las bendiciones materiales',
                'No es posible percibirlo',
              ],
              correctOptionIndex: 1,
              bibleReference: 'Juan 3:16; 1 Juan 4:9, 10',
            ),
            BibleQuestion(
              question: 'Debemos respetar el nombre de Dios',
              options: ['Verdadero', 'Falso'],
              correctOptionIndex: 0,
              bibleReference: 'Éxodo 20:7',
            ),
            BibleQuestion(
              question: 'Debemos obedecer a Dios',
              options: ['Verdadero', 'Falso'],
              correctOptionIndex: 0,
              bibleReference: 'Hechos 5:29',
            ),
            BibleQuestion(
              question: 'Debemos poner a Dios en primer lugar',
              options: ['Verdadero', 'Falso'],
              correctOptionIndex: 0,
              bibleReference: 'Mateo 6:33',
            ),
            BibleQuestion(
              question: 'Debemos amar a Dios de todo corazón',
              options: ['Verdadero', 'Falso'],
              correctOptionIndex: 0,
              bibleReference: 'Mateo 22:37',
            ),
          ],
        ),
      ],
    ),
  ];
}
