class HebrewLetter {
  final String symbol;
  final String name;
  final String transliteration;
  final String pronunciation;
  final String audioPath;
  final int numericValue;
  final String finalForm;
  final bool isGuttural;
  final bool isBegadkephat;
  final String notes;

  HebrewLetter({
    required this.symbol,
    required this.name,
    required this.transliteration,
    required this.pronunciation,
    this.audioPath = '',
    required this.numericValue,
    this.finalForm = '',
    this.isGuttural = false,
    this.isBegadkephat = false,
    this.notes = '',
  });
}

class HebrewLettersData {
  static List<HebrewLetter> letters = [
    HebrewLetter(
      symbol: 'א',
      name: "’alef",
      transliteration: "’",
      pronunciation: "’ (como espíritu suave griego)",
      audioPath: 'assets/audio/Alefbeto/1. Álef (א).mp3',
      numericValue: 1,
      isGuttural: true,
      notes: 'Consonante gutural, primera letra del alefato hebreo.',
    ),
    HebrewLetter(
      symbol: 'ב / בּ',
      name: 'beth',
      transliteration: 'b/v',
      pronunciation:
          'בּ (con dagesh): b como en "barco"; ב (sin dagesh): v como en "vaso"',
      audioPath: 'assets/audio/Alefbeto/2. Bet (ב).mp3',
      numericValue: 2,
      isBegadkephat: true,
      notes:
          'Letra begadkephat. Con dagesh (בּ) se pronuncia "b", sin dagesh (ב) se pronuncia "v".',
    ),
    HebrewLetter(
      symbol: 'ג / גּ',
      name: 'ghimel',
      transliteration: 'gu/g',
      pronunciation: 'g como en "gato", siempre sonido "ga, go, gu"',
      audioPath: 'assets/audio/Alefbeto/3. Guímel (ג).mp3',
      numericValue: 3,
      isBegadkephat: true,
      notes: 'Siempre equivale al sonido de la g como en ga, go, gu.',
    ),
    HebrewLetter(
      symbol: 'ד / דּ',
      name: 'daleth',
      transliteration: 'd',
      pronunciation: 'd como en "dedo"',
      audioPath: 'assets/audio/Alefbeto/4. Dálet (ד).mp3',
      numericValue: 4,
      isBegadkephat: true,
    ),
    HebrewLetter(
      symbol: 'ה',
      name: 'he',
      transliteration: 'h',
      pronunciation: 'h (aspirada)',
      audioPath: 'assets/audio/Alefbeto/5. Hei (ה).mp3',
      numericValue: 5,
      isGuttural: true,
    ),
    HebrewLetter(
      symbol: 'ו',
      name: 'waw',
      transliteration: 'w',
      pronunciation: 'w (inglesa)',
      audioPath: 'assets/audio/Alefbeto/6. Vav (ו).mp3',
      numericValue: 6,
    ),
    HebrewLetter(
      symbol: 'ז',
      name: 'zain',
      transliteration: 'z',
      pronunciation: 'z (suave)',
      audioPath: 'assets/audio/Alefbeto/7. Zayn (ז).mp3',
      numericValue: 7,
    ),
    HebrewLetter(
      symbol: 'ח',
      name: 'ḥeth',
      transliteration: 'ḥ',
      pronunciation: 'ḥ (gutural)',
      audioPath: 'assets/audio/Alefbeto/8. Jet (ח).mp3',
      numericValue: 8,
      isGuttural: true,
    ),
    HebrewLetter(
      symbol: 'ט',
      name: 'ṭeth',
      transliteration: 'ṭ',
      pronunciation: 'ṭ',
      audioPath: 'assets/audio/Alefbeto/9. Tet (ט).mp3',
      numericValue: 9,
    ),
    HebrewLetter(
      symbol: 'י',
      name: 'yod',
      transliteration: 'y',
      pronunciation: 'y',
      audioPath: 'assets/audio/Alefbeto/10. Yod (י).mp3',
      numericValue: 10,
    ),
    HebrewLetter(
      symbol: 'כ / כּ',
      name: 'kaf',
      transliteration: 'k/j',
      pronunciation:
          'כּ (con dagesh): k como en "kilo"; כ (sin dagesh): j como en "jamón"',
      audioPath: 'assets/audio/Alefbeto/11. Kaf (כ - ך ).mp3',
      numericValue: 20,
      finalForm: 'ך',
      isBegadkephat: true,
      notes:
          'Letra begadkephat. Tiene forma final (ך) cuando aparece al final de una palabra.',
    ),
    HebrewLetter(
      symbol: 'ל',
      name: 'lamed',
      transliteration: 'l',
      pronunciation: 'l como en "luna"',
      audioPath: 'assets/audio/Alefbeto/12. Lámed (ל).mp3',
      numericValue: 30,
    ),
    HebrewLetter(
      symbol: 'מ / ם',
      name: 'mem',
      transliteration: 'm',
      pronunciation: 'm como en "mamá"',
      audioPath: 'assets/audio/Alefbeto/13. Mem (מ - ם).mp3',
      numericValue: 40,
      finalForm: 'ם',
      notes: 'Tiene forma final (ם) cuando aparece al final de una palabra.',
    ),
    HebrewLetter(
      symbol: 'נ / ן',
      name: 'nun',
      transliteration: 'n',
      pronunciation: 'n como en "nada"',
      audioPath: 'assets/audio/Alefbeto/14. Nun (נ - ן).mp3',
      numericValue: 50,
      finalForm: 'ן',
      notes: 'Tiene forma final (ן) cuando aparece al final de una palabra.',
    ),
    HebrewLetter(
      symbol: 'ס',
      name: 'samekh',
      transliteration: 's',
      pronunciation: 's como en "sol"',
      audioPath: 'assets/audio/Alefbeto/15. Sámej (ס).mp3',
      numericValue: 60,
    ),
    HebrewLetter(
      symbol: 'ע',
      name: "'ayin",
      transliteration: "‘",
      pronunciation: '‘ (como espíritu rudo griego)',
      audioPath: 'assets/audio/Alefbeto/16. ʿayn (ע).mp3',
      numericValue: 70,
      isGuttural: true,
    ),
    HebrewLetter(
      symbol: 'פּ / ף',
      name: 'pe',
      transliteration: 'f (ph), p',
      pronunciation:
          'פּ (con dagesh): p como en "papá"; פ (sin dagesh): f como en "foca"',
      audioPath: 'assets/audio/Alefbeto/17. Pe (פ - ף).mp3',
      numericValue: 80,
      finalForm: 'ף',
      isBegadkephat: true,
      notes:
          'Letra begadkephat. Tiene forma final (ף) cuando aparece al final de una palabra.',
    ),
    HebrewLetter(
      symbol: 'צ / ץ',
      name: 'ṣade',
      transliteration: 'ṣ',
      pronunciation: 'ts como en "tsunami"',
      audioPath: 'assets/audio/Alefbeto/18. Tsade (צ - ץ).mp3',
      numericValue: 90,
      finalForm: 'ץ',
      notes: 'Tiene forma final (ץ) cuando aparece al final de una palabra.',
    ),
    HebrewLetter(
      symbol: 'ק',
      name: 'qof',
      transliteration: 'q',
      pronunciation: 'q',
      audioPath: 'assets/audio/Alefbeto/19. Kof (ק).mp3',
      numericValue: 100,
    ),
    HebrewLetter(
      symbol: 'ר',
      name: 'resh',
      transliteration: 'r',
      pronunciation: 'r suave como en francés',
      audioPath: 'assets/audio/Alefbeto/20. Resh (ר).mp3',
      numericValue: 200,
    ),
    HebrewLetter(
      symbol: 'שׂ',
      name: 'śin',
      transliteration: 'ś',
      pronunciation: 's como en "sol"',
      audioPath: 'assets/audio/Alefbeto/21. Sin (שׂ).mp3',
      numericValue: 300,
      notes: 'Con punto a la izquierda (שׂ) se pronuncia "s".',
    ),
    HebrewLetter(
      symbol: 'שׁ',
      name: 'šin (shin)',
      transliteration: 'š',
      pronunciation: 'sh como en inglés "show"',
      audioPath: 'assets/audio/Alefbeto/22. Shin (שׁ).mp3',
      numericValue: 300,
      notes: 'Con punto a la derecha (שׁ) se pronuncia "sh".',
    ),
    HebrewLetter(
      symbol: 'ת / תּ',
      name: 'tau',
      transliteration: 't',
      pronunciation: 't como en "taza"',
      audioPath: 'assets/audio/Alefbeto/23. Tau (ת).mp3',
      numericValue: 400,
      isBegadkephat: true,
    ),
  ];
}
