class GreekLetter {
  final String symbol;
  final String name;
  final String transliteration;
  final String pronunciation;
  final String audioPath;

  GreekLetter({
    required this.symbol,
    required this.name,
    required this.transliteration,
    required this.pronunciation,
    this.audioPath = '',
  });
}

class GreekLettersData {
  static List<GreekLetter> letters = [
    GreekLetter(
      symbol: 'Α α',
      name: 'Alfa',
      transliteration: 'a',
      pronunciation: 'a como en "casa"',
      audioPath: 'assets/audio/Alfabeto/1. Alfa (Αα).mp3',
    ),
    GreekLetter(
      symbol: 'Β β',
      name: 'Beta',
      transliteration: 'b',
      pronunciation: 'b como en "barco"',
      audioPath: 'assets/audio/Alfabeto/2. Beta (Ββ).mp3',
    ),
    GreekLetter(
      symbol: 'Γ γ',
      name: 'Gamma',
      transliteration: 'g',
      pronunciation: 'g como en "gato"',
      audioPath: 'assets/audio/Alfabeto/3. Gamma (Γγ).mp3',
    ),
    GreekLetter(
      symbol: 'Δ δ',
      name: 'Delta',
      transliteration: 'd',
      pronunciation: 'd como en "dedo"',
      audioPath: 'assets/audio/Alfabeto/4. Delta (Δδ).mp3',
    ),
    GreekLetter(
      symbol: 'Ε ε',
      name: 'Épsilon',
      transliteration: 'e',
      pronunciation: 'e como en "mesa"',
      audioPath: 'assets/audio/Alfabeto/5. Épsilon (Εε).mp3',
    ),
    GreekLetter(
      symbol: 'Ζ ζ',
      name: 'Dseta',
      transliteration: 'z',
      pronunciation: 'z como en "zapato"',
      audioPath: 'assets/audio/Alfabeto/6. Dseta (Ζζ).mp3',
    ),
    GreekLetter(
      symbol: 'Η η',
      name: 'Eta',
      transliteration: 'h',
      pronunciation: 'e larga como en "café"',
      audioPath: 'assets/audio/Alfabeto/7. Eta (Ηη).mp3',
    ),
    GreekLetter(
      symbol: 'Θ θ',
      name: 'Zeta',
      transliteration: 'th',
      pronunciation: 'th como en inglés "think"',
      audioPath: 'assets/audio/Alfabeto/8. Zeta (Θθ).mp3',
    ),
    GreekLetter(
      symbol: 'Ι ι',
      name: 'Iota',
      transliteration: 'i',
      pronunciation: 'i como en "hijo"',
      audioPath: 'assets/audio/Alfabeto/9. Iota (Ιι).mp3',
    ),
    GreekLetter(
      symbol: 'Κ κ',
      name: 'Kappa',
      transliteration: 'k',
      pronunciation: 'k como en "kilo"',
      audioPath: 'assets/audio/Alfabeto/10. Kappa (Κκ).mp3',
    ),
    GreekLetter(
      symbol: 'Λ λ',
      name: 'Lambda',
      transliteration: 'l',
      pronunciation: 'l como en "luna"',
      audioPath: 'assets/audio/Alfabeto/11. Lambda (Λλ).mp3',
    ),
    GreekLetter(
      symbol: 'Μ μ',
      name: 'Mi',
      transliteration: 'm',
      pronunciation: 'm como en "mamá"',
      audioPath: 'assets/audio/Alfabeto/12. Mi (Μμ).mp3',
    ),
    GreekLetter(
      symbol: 'Ν ν',
      name: 'Ni',
      transliteration: 'n',
      pronunciation: 'n como en "nada"',
      audioPath: 'assets/audio/Alfabeto/13. Ni (Νν).mp3',
    ),
    GreekLetter(
      symbol: 'Ξ ξ',
      name: 'Xi',
      transliteration: 'x',
      pronunciation: 'x como en "taxi"',
      audioPath: 'assets/audio/Alfabeto/14. Xi (Ξξ).mp3',
    ),
    GreekLetter(
      symbol: 'Ο ο',
      name: 'Omicron',
      transliteration: 'o',
      pronunciation: 'o corta como en "oso"',
      audioPath: 'assets/audio/Alfabeto/15. Ómicron (Οο).mp3',
    ),
    GreekLetter(
      symbol: 'Π π',
      name: 'Pi',
      transliteration: 'p',
      pronunciation: 'p como en "papá"',
      audioPath: 'assets/audio/Alfabeto/16. Pi (Ππ).mp3',
    ),
    GreekLetter(
      symbol: 'Ρ ρ',
      name: 'Ro',
      transliteration: 'r',
      pronunciation: 'r como en "rosa"',
      audioPath: 'assets/audio/Alfabeto/17. Ro (Ρρ).mp3',
    ),
    GreekLetter(
      symbol: 'Σ σ',
      name: 'Sigma',
      transliteration: 's',
      pronunciation: 's como en "sol"',
      audioPath: 'assets/audio/Alfabeto/18. Sigma (Σσ).mp3',
    ),
    GreekLetter(
      symbol: 'Τ τ',
      name: 'Tau',
      transliteration: 't',
      pronunciation: 't como en "taza"',
      audioPath: 'assets/audio/Alfabeto/19. Tau (Ττ).mp3',
    ),
    GreekLetter(
      symbol: 'Υ υ',
      name: 'Ípsilon',
      transliteration: 'y',
      pronunciation: 'y como en "y griega"',
      audioPath: 'assets/audio/Alfabeto/20. Ípsilon (Υυ).mp3',
    ),
    GreekLetter(
      symbol: 'Φ φ',
      name: 'Fi',
      transliteration: 'f',
      pronunciation: 'f como en "foca"',
      audioPath: 'assets/audio/Alfabeto/21. Fi (Φφ).mp3',
    ),
    GreekLetter(
      symbol: 'Χ χ',
      name: 'Ji',
      transliteration: 'x',
      pronunciation: 'j fuerte como en alemán "Bach"',
      audioPath: 'assets/audio/Alfabeto/22. Ji (Χχ).mp3',
    ),
    GreekLetter(
      symbol: 'Ψ ψ',
      name: 'Psi',
      transliteration: 'ps',
      pronunciation: 'ps como en "psicología"',
      audioPath: 'assets/audio/Alfabeto/23. Psi (Ψψ).mp3',
    ),
    GreekLetter(
      symbol: 'Ω ω',
      name: 'Omega',
      transliteration: 'o',
      pronunciation: 'o larga como en "sol"',
      audioPath: 'assets/audio/Alfabeto/24. Omega (Ωω).mp3',
    ),
  ];
}
