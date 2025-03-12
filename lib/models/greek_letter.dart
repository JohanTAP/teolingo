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
      name: 'Alpha',
      transliteration: 'a',
      pronunciation: 'a como en "casa"',
      audioPath: 'assets/audio/Alfabeto/1. Alpha.mp3',
    ),
    GreekLetter(
      symbol: 'Β β',
      name: 'Beta',
      transliteration: 'b',
      pronunciation: 'b como en "barco"',
      audioPath: 'assets/audio/Alfabeto/2. Beta.mp3',
    ),
    GreekLetter(
      symbol: 'Γ γ',
      name: 'Gamma',
      transliteration: 'g',
      pronunciation: 'g como en "gato"',
      audioPath: 'assets/audio/Alfabeto/3. Gamma.mp3',
    ),
    GreekLetter(
      symbol: 'Δ δ',
      name: 'Delta',
      transliteration: 'd',
      pronunciation: 'd como en "dedo"',
      audioPath: 'assets/audio/Alfabeto/4. Delta.mp3',
    ),
    GreekLetter(
      symbol: 'Ε ε',
      name: 'Epsilon',
      transliteration: 'e',
      pronunciation: 'e como en "mesa"',
      audioPath: 'assets/audio/Alfabeto/5. Epsilon.mp3',
    ),
    GreekLetter(
      symbol: 'Ζ ζ',
      name: 'Zeta',
      transliteration: 'z',
      pronunciation: 'z como en "zapato"',
      audioPath: 'assets/audio/Alfabeto/6. Zeta.mp3',
    ),
    GreekLetter(
      symbol: 'Η η',
      name: 'Eta',
      transliteration: 'ē',
      pronunciation: 'e larga como en "café"',
      audioPath: 'assets/audio/Alfabeto/7. Eta.mp3',
    ),
    GreekLetter(
      symbol: 'Θ θ',
      name: 'Theta',
      transliteration: 'th',
      pronunciation: 'th como en inglés "think"',
      audioPath: 'assets/audio/Alfabeto/8. Theta.mp3',
    ),
    GreekLetter(
      symbol: 'Ι ι',
      name: 'Iota',
      transliteration: 'i',
      pronunciation: 'i como en "hijo"',
      audioPath: 'assets/audio/Alfabeto/9. Iota.mp3',
    ),
    GreekLetter(
      symbol: 'Κ κ',
      name: 'Kappa',
      transliteration: 'k',
      pronunciation: 'k como en "kilo"',
      audioPath: 'assets/audio/Alfabeto/10. Kappa.mp3',
    ),
    GreekLetter(
      symbol: 'Λ λ',
      name: 'Lambda',
      transliteration: 'l',
      pronunciation: 'l como en "luna"',
      audioPath: 'assets/audio/Alfabeto/11. Lambda.mp3',
    ),
    GreekLetter(
      symbol: 'Μ μ',
      name: 'Mu',
      transliteration: 'm',
      pronunciation: 'm como en "mamá"',
      audioPath: 'assets/audio/Alfabeto/12. Mu.mp3',
    ),
    GreekLetter(
      symbol: 'Ν ν',
      name: 'Nu',
      transliteration: 'n',
      pronunciation: 'n como en "nada"',
      audioPath: 'assets/audio/Alfabeto/13. Nu.mp3',
    ),
    GreekLetter(
      symbol: 'Ξ ξ',
      name: 'Xi',
      transliteration: 'x',
      pronunciation: 'x como en "taxi"',
      audioPath: 'assets/audio/Alfabeto/14. Xi.mp3',
    ),
    GreekLetter(
      symbol: 'Ο ο',
      name: 'Omicron',
      transliteration: 'o',
      pronunciation: 'o corta como en "oso"',
      audioPath: 'assets/audio/Alfabeto/15. Omicron.mp3',
    ),
    GreekLetter(
      symbol: 'Π π',
      name: 'Pi',
      transliteration: 'p',
      pronunciation: 'p como en "papá"',
      audioPath: 'assets/audio/Alfabeto/16. Pi.mp3',
    ),
    GreekLetter(
      symbol: 'Ρ ρ',
      name: 'Rho',
      transliteration: 'r',
      pronunciation: 'r como en "rosa"',
      audioPath: 'assets/audio/Alfabeto/17. Rho.mp3',
    ),
    GreekLetter(
      symbol: 'Σ σ/ς',
      name: 'Sigma',
      transliteration: 's',
      pronunciation: 's como en "sol"',
      audioPath: 'assets/audio/Alfabeto/18. Sigma.mp3',
    ),
    GreekLetter(
      symbol: 'Τ τ',
      name: 'Tau',
      transliteration: 't',
      pronunciation: 't como en "taza"',
      audioPath: 'assets/audio/Alfabeto/19. Tau.mp3',
    ),
    GreekLetter(
      symbol: 'Υ υ',
      name: 'Upsilon',
      transliteration: 'u/y',
      pronunciation: 'u francesa o y como en "y griega"',
      audioPath: 'assets/audio/Alfabeto/20. Upsilon.mp3',
    ),
    GreekLetter(
      symbol: 'Φ φ',
      name: 'Phi',
      transliteration: 'ph',
      pronunciation: 'f como en "foca"',
      audioPath: 'assets/audio/Alfabeto/21. Phi.mp3',
    ),
    GreekLetter(
      symbol: 'Χ χ',
      name: 'Chi',
      transliteration: 'ch',
      pronunciation: 'j fuerte como en alemán "Bach"',
      audioPath: 'assets/audio/Alfabeto/22. Chi.mp3',
    ),
    GreekLetter(
      symbol: 'Ψ ψ',
      name: 'Psi',
      transliteration: 'ps',
      pronunciation: 'ps como en "psicología"',
      audioPath: 'assets/audio/Alfabeto/23. Psi.mp3',
    ),
    GreekLetter(
      symbol: 'Ω ω',
      name: 'Omega',
      transliteration: 'ō',
      pronunciation: 'o larga como en "sol"',
      audioPath: 'assets/audio/Alfabeto/24. Omega.mp3',
    ),
  ];
}
