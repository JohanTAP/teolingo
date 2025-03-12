import 'dart:math';

/// Clase para generar y validar claves de activación
class KeyGenerator {
  static final Random _random = Random();
  static const String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  // Clave especial para el nivel 4
  static const String SPECIAL_KEY_LEVEL4 = 'Ve22081850';

  /// Genera una clave de activación para el nivel especificado
  /// [level] debe ser 2, 3, 4, 5, 6 o 7
  static String generateKey(int level) {
    assert(level >= 2 && level <= 7, 'El nivel debe ser entre 2 y 7');

    // Generar la segunda parte (4 caracteres)
    String part2 = '';
    for (int i = 0; i < 4; i++) {
      part2 += _chars[_random.nextInt(_chars.length)];
    }

    // Generar la tercera parte (4 caracteres)
    String part3 = '';
    for (int i = 0; i < 4; i++) {
      part3 += _chars[_random.nextInt(_chars.length)];
    }

    // Combinar las partes
    return 'LEVEL$level-$part2-$part3';
  }

  /// Genera múltiples claves de activación
  /// [level] debe ser 2, 3, 4, 5, 6 o 7
  /// [count] es el número de claves a generar
  static List<String> generateMultipleKeys(int level, int count) {
    List<String> keys = [];
    for (int i = 0; i < count; i++) {
      keys.add(generateKey(level));
    }
    return keys;
  }

  /// Valida si una clave tiene el formato correcto
  static bool isValidKeyFormat(String key) {
    // Verificar si es la clave especial para el nivel 4
    if (key == SPECIAL_KEY_LEVEL4) {
      print('Clave especial para nivel 4 detectada');
      return true;
    }

    // Verificar el formato: LEVELX-XXXX-XXXX donde X es alfanumérico
    final RegExp keyFormat = RegExp(r'^LEVEL[2-7]-[A-Z0-9]{4}-[A-Z0-9]{4}$');
    return keyFormat.hasMatch(key);
  }

  /// Obtiene el nivel de una clave
  /// Retorna 0 si la clave no es válida
  static int getLevelFromKey(String key) {
    // Verificar si es la clave especial para el nivel 4
    if (key == SPECIAL_KEY_LEVEL4) {
      print('Clave especial para nivel 4 detectada');
      return 4;
    }

    if (!isValidKeyFormat(key)) {
      print('Formato de clave inválido: $key');
      return 0;
    }

    print('Verificando nivel para clave: $key');

    if (key.startsWith('LEVEL7')) {
      print('Clave de nivel 7 detectada');
      return 7;
    }
    if (key.startsWith('LEVEL6')) {
      print('Clave de nivel 6 detectada');
      return 6;
    }
    if (key.startsWith('LEVEL5')) {
      print('Clave de nivel 5 detectada');
      return 5;
    }
    if (key.startsWith('LEVEL4')) {
      print('Clave de nivel 4 detectada');
      return 4;
    }
    if (key.startsWith('LEVEL3')) {
      print('Clave de nivel 3 detectada');
      return 3;
    }
    if (key.startsWith('LEVEL2')) {
      print('Clave de nivel 2 detectada');
      return 2;
    }

    print('Nivel no detectado en la clave');
    return 0;
  }
}

// Ejemplo de uso:
void main() {
  // Generar 5 claves para el nivel 2
  print('Claves para Nivel 2:');
  final level2Keys = KeyGenerator.generateMultipleKeys(2, 5);
  for (final key in level2Keys) {
    print(key);
  }

  // Generar 5 claves para el nivel 3
  print('\nClaves para Nivel 3:');
  final level3Keys = KeyGenerator.generateMultipleKeys(3, 5);
  for (final key in level3Keys) {
    print(key);
  }

  // Generar 5 claves para el nivel 4
  print('\nClaves para Nivel 4:');
  final level4Keys = KeyGenerator.generateMultipleKeys(4, 5);
  for (final key in level4Keys) {
    print(key);
  }

  // Validar una clave
  final testKey = 'LEVEL3-ABCD-1234';
  print('\nValidando clave: $testKey');
  print('¿Formato válido? ${KeyGenerator.isValidKeyFormat(testKey)}');
  print('Nivel: ${KeyGenerator.getLevelFromKey(testKey)}');

  // Validar la clave especial para el nivel 4
  final specialKey = KeyGenerator.SPECIAL_KEY_LEVEL4;
  print('\nValidando clave especial: $specialKey');
  print('¿Formato válido? ${KeyGenerator.isValidKeyFormat(specialKey)}');
  print('Nivel: ${KeyGenerator.getLevelFromKey(specialKey)}');
}
