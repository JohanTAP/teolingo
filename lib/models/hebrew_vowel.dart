enum VowelType { long, short, semiVowel }

class HebrewVowel {
  final String symbol;
  final String name;
  final String transliteration;
  final String pronunciation;
  final String audioPath;
  final VowelType type;
  final bool isCompoundShewa;
  final String notes;
  final int numericValue;
  final String finalForm;
  final bool isGuttural;
  final bool isBegadkephat;

  HebrewVowel({
    required this.symbol,
    required this.name,
    required this.transliteration,
    required this.pronunciation,
    this.audioPath = '',
    required this.type,
    this.isCompoundShewa = false,
    this.notes = '',
    this.numericValue = 0,
    this.finalForm = '',
    this.isGuttural = false,
    this.isBegadkephat = false,
  });
}

class HebrewVowelsData {
  static List<HebrewVowel> vowels = [
    // Vocales largas
    HebrewVowel(
      symbol: 'ָ',
      name: 'qamets',
      transliteration: 'ā',
      pronunciation: 'a larga como en "padre"',
      audioPath: 'assets/audio/Vocales/1. Qamets.mp3',
      type: VowelType.long,
      notes: 'Vocal larga. Se coloca debajo de la consonante.',
    ),
    HebrewVowel(
      symbol: 'ֵ',
      name: 'tsere',
      transliteration: 'ē',
      pronunciation: 'e larga como en "mesa"',
      audioPath: 'assets/audio/Vocales/2. Tsere.mp3',
      type: VowelType.long,
      notes: 'Vocal larga. Se coloca debajo de la consonante.',
    ),
    HebrewVowel(
      symbol: 'ִי',
      name: 'hireq yod',
      transliteration: 'ī',
      pronunciation: 'i larga como en "vida"',
      audioPath: 'assets/audio/Vocales/3. Hireq Yod.mp3',
      type: VowelType.long,
      notes:
          'Vocal larga. El punto se coloca debajo de la consonante y va seguido de yod.',
    ),
    HebrewVowel(
      symbol: 'ֹ',
      name: 'holem',
      transliteration: 'ō',
      pronunciation: 'o larga como en "oso"',
      audioPath: 'assets/audio/Vocales/4. Holem.mp3',
      type: VowelType.long,
      notes: 'Vocal larga. Se coloca encima de la consonante a la izquierda.',
    ),
    HebrewVowel(
      symbol: 'וּ',
      name: 'shureq',
      transliteration: 'ū',
      pronunciation: 'u larga como en "luna"',
      audioPath: 'assets/audio/Vocales/5. Shureq.mp3',
      type: VowelType.long,
      notes: 'Vocal larga. El punto se coloca en el centro de la letra waw.',
    ),

    // Vocales cortas
    HebrewVowel(
      symbol: 'ַ',
      name: 'pataj',
      transliteration: 'a',
      pronunciation: 'a corta como en "casa"',
      audioPath: 'assets/audio/Vocales/6. Pataj.mp3',
      type: VowelType.short,
      notes: 'Vocal corta. Se coloca debajo de la consonante.',
    ),
    HebrewVowel(
      symbol: 'ֶ',
      name: 'segol',
      transliteration: 'e',
      pronunciation: 'e corta como en "mesa"',
      audioPath: 'assets/audio/Vocales/7. Segol.mp3',
      type: VowelType.short,
      notes: 'Vocal corta. Se coloca debajo de la consonante.',
    ),
    HebrewVowel(
      symbol: 'ִ',
      name: 'hireq',
      transliteration: 'i',
      pronunciation: 'i corta como en "hijo"',
      audioPath: 'assets/audio/Vocales/8. Hireq.mp3',
      type: VowelType.short,
      notes: 'Vocal corta. Se coloca debajo de la consonante.',
    ),
    HebrewVowel(
      symbol: 'ָ',
      name: 'qamets jatuf',
      transliteration: 'o',
      pronunciation: 'o corta como en "boca"',
      audioPath: 'assets/audio/Vocales/9. Qamets Jatuf.mp3',
      type: VowelType.short,
      notes:
          'Vocal corta. Tiene el mismo signo que qamets pero se pronuncia como "o".',
    ),
    HebrewVowel(
      symbol: 'ֻ',
      name: 'qibbuts',
      transliteration: 'u',
      pronunciation: 'u corta como en "puro"',
      audioPath: 'assets/audio/Vocales/10. Qibbuts.mp3',
      type: VowelType.short,
      notes: 'Vocal corta. Se coloca debajo de la consonante.',
    ),

    // Semivocales (shewá)
    HebrewVowel(
      symbol: 'ְ',
      name: 'shewá',
      transliteration: 'e',
      pronunciation: 'e muy breve, casi muda',
      audioPath: 'assets/audio/Vocales/11. Shewa.mp3',
      type: VowelType.semiVowel,
      notes:
          'Semivocal. Puede ser vocal (al inicio de palabra o sílaba) o muda (al final de sílaba).',
    ),
    HebrewVowel(
      symbol: 'ֲ',
      name: 'hatef pataj',
      transliteration: 'a',
      pronunciation: 'a muy breve',
      audioPath: 'assets/audio/Vocales/12. Hatef Pataj.mp3',
      type: VowelType.semiVowel,
      isCompoundShewa: true,
      notes: 'Shewá compuesto. Se usa principalmente con letras guturales.',
    ),
    HebrewVowel(
      symbol: 'ֱ',
      name: 'hatef segol',
      transliteration: 'e',
      pronunciation: 'e muy breve',
      audioPath: 'assets/audio/Vocales/13. Hatef Segol.mp3',
      type: VowelType.semiVowel,
      isCompoundShewa: true,
      notes: 'Shewá compuesto. Se usa principalmente con letras guturales.',
    ),
    HebrewVowel(
      symbol: 'ֳ',
      name: 'hatef qamets',
      transliteration: 'o',
      pronunciation: 'o muy breve',
      audioPath: 'assets/audio/Vocales/14. Hatef Qamets.mp3',
      type: VowelType.semiVowel,
      isCompoundShewa: true,
      notes: 'Shewá compuesto. Se usa principalmente con letras guturales.',
    ),
  ];
}
