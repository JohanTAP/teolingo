class HebrewLetter {
  final String symbol;
  final String name;
  final String transliteration;
  final String pronunciation;
  final String audioPath;

  HebrewLetter({
    required this.symbol,
    required this.name,
    required this.transliteration,
    required this.pronunciation,
    this.audioPath = '',
  });
}

class HebrewLettersData {
  static List<HebrewLetter> letters = [
    HebrewLetter(
      symbol: 'א',
      name: 'Alef',
      transliteration: 'ʾ',
      pronunciation: 'Sonido glotal (pausa)',
      audioPath: 'assets/audio/Alefbeto/1. Álef (א).mp3',
    ),
    HebrewLetter(
      symbol: 'ב',
      name: 'Bet',
      transliteration: 'b/v',
      pronunciation: 'b como en "barco" o v como en "vaso"',
      audioPath: 'assets/audio/Alefbeto/2. Bet (ב).mp3',
    ),
    HebrewLetter(
      symbol: 'ג',
      name: 'Guimel',
      transliteration: 'g',
      pronunciation: 'g como en "gato"',
      audioPath: 'assets/audio/Alefbeto/3. Guímel (ג).mp3',
    ),
    HebrewLetter(
      symbol: 'ד',
      name: 'Dalet',
      transliteration: 'd',
      pronunciation: 'd como en "dedo"',
      audioPath: 'assets/audio/Alefbeto/4. Dálet (ד).mp3',
    ),
    HebrewLetter(
      symbol: 'ה',
      name: 'He',
      transliteration: 'h',
      pronunciation: 'h aspirada suave',
      audioPath: 'assets/audio/Alefbeto/5. Hei (ה).mp3',
    ),
    HebrewLetter(
      symbol: 'ו',
      name: 'Vav',
      transliteration: 'v/w',
      pronunciation: 'v como en "vaso" o w',
      audioPath: 'assets/audio/Alefbeto/6. Vav (ו).mp3',
    ),
    HebrewLetter(
      symbol: 'ז',
      name: 'Zayin',
      transliteration: 'z',
      pronunciation: 'z como en "zapato"',
      audioPath: 'assets/audio/Alefbeto/7. Zayn (ז).mp3',
    ),
    HebrewLetter(
      symbol: 'ח',
      name: 'Jet',
      transliteration: 'j',
      pronunciation: 'j fuerte como en alemán "Bach"',
      audioPath: 'assets/audio/Alefbeto/8. Jet (ח).mp3',
    ),
    HebrewLetter(
      symbol: 'ט',
      name: 'Tet',
      transliteration: 't',
      pronunciation: 't enfática',
      audioPath: 'assets/audio/Alefbeto/9. Tet (ט).mp3',
    ),
    HebrewLetter(
      symbol: 'י',
      name: 'Yod',
      transliteration: 'y',
      pronunciation: 'y como en "yo"',
      audioPath: 'assets/audio/Alefbeto/10. Yod (י).mp3',
    ),
    HebrewLetter(
      symbol: 'כ',
      name: 'Kaf',
      transliteration: 'k/j',
      pronunciation: 'k como en "kilo" o j como en alemán "Bach"',
      audioPath: 'assets/audio/Alefbeto/11. Kaf (כ - ך ).mp3',
    ),
    HebrewLetter(
      symbol: 'ל',
      name: 'Lamed',
      transliteration: 'l',
      pronunciation: 'l como en "luna"',
      audioPath: 'assets/audio/Alefbeto/12. Lámed (ל).mp3',
    ),
    HebrewLetter(
      symbol: 'מ',
      name: 'Mem',
      transliteration: 'm',
      pronunciation: 'm como en "mamá"',
      audioPath: 'assets/audio/Alefbeto/13. Mem (מ - ם).mp3',
    ),
    HebrewLetter(
      symbol: 'נ',
      name: 'Nun',
      transliteration: 'n',
      pronunciation: 'n como en "nada"',
      audioPath: 'assets/audio/Alefbeto/14. Nun (נ - ן).mp3',
    ),
    HebrewLetter(
      symbol: 'ס',
      name: 'Samej',
      transliteration: 's',
      pronunciation: 's como en "sol"',
      audioPath: 'assets/audio/Alefbeto/15. Sámej (ס).mp3',
    ),
    HebrewLetter(
      symbol: 'ע',
      name: 'Ayin',
      transliteration: 'ʿ',
      pronunciation: 'Sonido gutural (desde la garganta)',
      audioPath: 'assets/audio/Alefbeto/16. ʿayn (ע).mp3',
    ),
    HebrewLetter(
      symbol: 'פ',
      name: 'Pe',
      transliteration: 'p/f',
      pronunciation: 'p como en "papá" o f como en "foca"',
      audioPath: 'assets/audio/Alefbeto/17. Pe (פ - ף).mp3',
    ),
    HebrewLetter(
      symbol: 'צ',
      name: 'Tsadi',
      transliteration: 'ts',
      pronunciation: 'ts como en "tsunami"',
      audioPath: 'assets/audio/Alefbeto/18. Tsade (צ - ץ).mp3',
    ),
    HebrewLetter(
      symbol: 'ק',
      name: 'Qof',
      transliteration: 'q',
      pronunciation: 'k gutural profunda',
      audioPath: 'assets/audio/Alefbeto/19. Kof (ק).mp3',
    ),
    HebrewLetter(
      symbol: 'ר',
      name: 'Resh',
      transliteration: 'r',
      pronunciation: 'r suave como en francés',
      audioPath: 'assets/audio/Alefbeto/20. Resh (ר).mp3',
    ),
    HebrewLetter(
      symbol: 'ש',
      name: 'Shin/Sin',
      transliteration: 'sh/s',
      pronunciation: 'sh como en "show" o s como en "sol"',
      audioPath: 'assets/audio/Alefbeto/21. Shin (ש).mp3',
    ),
    HebrewLetter(
      symbol: 'ת',
      name: 'Tav',
      transliteration: 't',
      pronunciation: 't como en "taza"',
      audioPath: 'assets/audio/Alefbeto/22. Tau (ת).mp3',
    ),
  ];
}
