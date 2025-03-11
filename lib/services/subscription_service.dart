import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../utils/key_generator.dart';

class SubscriptionService {
  static const String _dbName = 'aprende_hebreo.db';
  static const String _tableName = 'subscriptions';
  static Database? _database;
  
  // Claves para SharedPreferences
  static const String _keysListKey = 'subscription_keys';
  static const String _unlockedLevelKey = 'unlockedLevel';
  static const String _deviceIdKey = 'deviceId';

  // Singleton pattern
  static final SubscriptionService _instance = SubscriptionService._internal();
  factory SubscriptionService() => _instance;
  SubscriptionService._internal();

  // Obtener la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;
    try {
      _database = await _initDatabase();
      debugPrint('Base de datos inicializada correctamente');
      return _database!;
    } catch (e) {
      debugPrint('Error al inicializar la base de datos: $e');
      rethrow;
    }
  }

  // Inicializar la base de datos
  Future<Database> _initDatabase() async {
    try {
      debugPrint('Iniciando inicialización de la base de datos');
      final String path = join(await getDatabasesPath(), _dbName);
      debugPrint('Ruta de la base de datos: $path');
      
      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          debugPrint('Creando tabla $_tableName');
          await db.execute(
            '''
            CREATE TABLE $_tableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              key TEXT NOT NULL,
              level INTEGER NOT NULL,
              activationDate TEXT NOT NULL,
              expiryDate TEXT,
              deviceId TEXT NOT NULL
            )
            ''',
          );
          debugPrint('Tabla $_tableName creada correctamente');
        },
        onOpen: (db) {
          debugPrint('Base de datos abierta correctamente');
        },
      );
    } catch (e) {
      debugPrint('Error en _initDatabase: $e');
      rethrow;
    }
  }

  // Verificar si una clave es válida
  Future<bool> validateKey(String key) async {
    try {
      debugPrint('Validando clave: $key');
      
      // Verificar el formato de la clave
      if (!KeyGenerator.isValidKeyFormat(key)) {
        debugPrint('Formato de clave inválido');
        return false;
      }
      
      // Si estamos en la web, usamos SharedPreferences
      if (kIsWeb) {
        return await _validateKeyWithPrefs(key);
      }
      
      // En dispositivos móviles o de escritorio, usamos SQLite
      return await _validateKeyWithSQLite(key);
    } catch (e) {
      debugPrint('Error al validar clave: $e');
      // En caso de error, permitimos continuar para intentar activar la clave
      return true;
    }
  }
  
  // Validar clave usando SharedPreferences (para Web)
  Future<bool> _validateKeyWithPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> keys = prefs.getStringList(_keysListKey) ?? [];
    
    debugPrint('Claves almacenadas en SharedPreferences: $keys');
    
    // Si la clave ya está registrada, es válida
    if (keys.contains(key)) {
      debugPrint('Clave encontrada en SharedPreferences');
      return true;
    }
    
    // Si la clave no está registrada pero tiene formato válido, es válida
    debugPrint('Clave no encontrada en SharedPreferences, pero formato válido');
    return true;
  }
  
  // Validar clave usando SQLite (para móvil/desktop)
  Future<bool> _validateKeyWithSQLite(String key) async {
    // Verificar si la clave ya está registrada en este dispositivo
    final db = await database;
    debugPrint('Consultando clave en la base de datos');
    
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: 'key = ?',
      whereArgs: [key],
    );
    
    debugPrint('Resultados encontrados: ${result.length}');
    
    if (result.isNotEmpty) {
      // La clave ya está registrada, verificar si ha expirado
      final Map<String, dynamic> subscription = result.first;
      final String? expiryDateStr = subscription['expiryDate'];
      
      if (expiryDateStr != null) {
        final DateTime expiryDate = DateTime.parse(expiryDateStr);
        if (expiryDate.isBefore(DateTime.now())) {
          debugPrint('La suscripción ha expirado');
          return false; // La suscripción ha expirado
        }
      }
      
      debugPrint('Clave válida y activa');
      return true; // La clave es válida y no ha expirado
    }
    
    // La clave no está registrada pero tiene formato válido
    debugPrint('Clave con formato válido, no registrada previamente');
    return true;
  }

  // Activar una suscripción con una clave
  Future<bool> activateSubscription(String key) async {
    try {
      debugPrint('Iniciando activación de suscripción con clave: $key');
      
      if (!await validateKey(key)) {
        debugPrint('Clave inválida');
        return false;
      }
      
      // Si estamos en la web, usamos SharedPreferences
      if (kIsWeb) {
        return await _activateSubscriptionWithPrefs(key);
      }
      
      // En dispositivos móviles o de escritorio, usamos SQLite
      return await _activateSubscriptionWithSQLite(key);
    } catch (e) {
      debugPrint('Error al activar suscripción: $e');
      return false;
    }
  }
  
  // Activar suscripción usando SharedPreferences (para Web)
  Future<bool> _activateSubscriptionWithPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> keys = prefs.getStringList(_keysListKey) ?? [];
    
    // Si la clave ya está registrada, ya está activada
    if (keys.contains(key)) {
      debugPrint('Clave ya activada en SharedPreferences');
      return true;
    }
    
    // Registrar la nueva clave
    keys.add(key);
    await prefs.setStringList(_keysListKey, keys);
    debugPrint('Clave agregada a SharedPreferences: $key');
    
    // Actualizar el nivel desbloqueado
    final int level = KeyGenerator.getLevelFromKey(key);
    debugPrint('Nivel obtenido de la clave: $level');
    final int currentLevel = prefs.getInt(_unlockedLevelKey) ?? 1;
    debugPrint('Nivel actual en SharedPreferences: $currentLevel');
    
    if (level > currentLevel) {
      await prefs.setInt(_unlockedLevelKey, level);
      debugPrint('Nivel actualizado en SharedPreferences: $level');
    }
    
    return true;
  }
  
  // Activar suscripción usando SQLite (para móvil/desktop)
  Future<bool> _activateSubscriptionWithSQLite(String key) async {
    debugPrint('Clave validada, obteniendo ID de dispositivo');
    final String deviceId = await _getDeviceId();
    debugPrint('ID de dispositivo: $deviceId');
    
    debugPrint('Obteniendo base de datos');
    final db = await database;
    
    // Verificar si la clave ya está registrada
    debugPrint('Verificando si la clave ya está registrada');
    final List<Map<String, dynamic>> existingKeys = await db.query(
      _tableName,
      where: 'key = ?',
      whereArgs: [key],
    );
    
    if (existingKeys.isNotEmpty) {
      debugPrint('Clave ya registrada, verificando dispositivo');
      // La clave ya está registrada, actualizar si es necesario
      final Map<String, dynamic> subscription = existingKeys.first;
      if (subscription['deviceId'] != deviceId) {
        debugPrint('La clave está siendo usada en otro dispositivo');
        return false;
      }
      
      // Actualizar la fecha de expiración si es necesario
      debugPrint('Clave ya activada en este dispositivo');
      return true;
    }
    
    // Registrar la nueva clave
    debugPrint('Registrando nueva clave');
    final now = DateTime.now();
    final expiryDate = now.add(const Duration(days: 365)); // Suscripción por 1 año
    final level = KeyGenerator.getLevelFromKey(key);
    debugPrint('Nivel obtenido de la clave: $level');
    
    debugPrint('Insertando clave en la base de datos, nivel: $level');
    final int id = await db.insert(
      _tableName,
      {
        'key': key,
        'level': level,
        'activationDate': now.toIso8601String(),
        'expiryDate': expiryDate.toIso8601String(),
        'deviceId': deviceId,
      },
    );
    
    debugPrint('Clave insertada con ID: $id');
    
    // Guardar el nivel desbloqueado en SharedPreferences
    debugPrint('Actualizando nivel desbloqueado en SharedPreferences');
    final prefs = await SharedPreferences.getInstance();
    final currentLevel = prefs.getInt(_unlockedLevelKey) ?? 1;
    debugPrint('Nivel actual: $currentLevel, nuevo nivel: $level');
    
    if (level > currentLevel) {
      await prefs.setInt(_unlockedLevelKey, level);
      debugPrint('Nivel actualizado a: $level');
    }
    
    debugPrint('Suscripción activada correctamente');
    return true;
  }

  // Obtener el nivel máximo desbloqueado
  Future<int> getUnlockedLevel() async {
    try {
      debugPrint('Obteniendo nivel desbloqueado...');
      final prefs = await SharedPreferences.getInstance();
      
      // Verificar si hay claves registradas
      final List<String> keys = prefs.getStringList(_keysListKey) ?? [];
      debugPrint('Claves registradas: ${keys.length}');
      
      // Obtener el nivel almacenado en SharedPreferences
      final int storedLevel = prefs.getInt(_unlockedLevelKey) ?? 1;
      debugPrint('Nivel almacenado en SharedPreferences: $storedLevel');
      
      // Si estamos en la web, verificar si hay claves de nivel 3
      if (kIsWeb && keys.isNotEmpty) {
        int maxKeyLevel = 1;
        for (final key in keys) {
          final int keyLevel = KeyGenerator.getLevelFromKey(key);
          debugPrint('Clave: $key, Nivel: $keyLevel');
          if (keyLevel > maxKeyLevel) {
            maxKeyLevel = keyLevel;
          }
        }
        
        debugPrint('Nivel máximo de las claves: $maxKeyLevel');
        
        // Si el nivel de las claves es mayor que el almacenado, actualizarlo
        if (maxKeyLevel > storedLevel) {
          debugPrint('Actualizando nivel almacenado de $storedLevel a $maxKeyLevel');
          await prefs.setInt(_unlockedLevelKey, maxKeyLevel);
          return maxKeyLevel;
        }
      }
      
      debugPrint('Nivel desbloqueado final: $storedLevel');
      return storedLevel;
    } catch (e) {
      debugPrint('Error al obtener nivel desbloqueado: $e');
      return 1; // Por defecto, nivel 1
    }
  }

  // Verificar si un nivel específico está desbloqueado
  Future<bool> isLevelUnlocked(int level) async {
    try {
      final int unlockedLevel = await getUnlockedLevel();
      final bool isUnlocked = level <= unlockedLevel;
      debugPrint('Verificando nivel $level, desbloqueado: $isUnlocked');
      return isUnlocked;
    } catch (e) {
      debugPrint('Error al verificar nivel desbloqueado: $e');
      return level == 1; // Solo el nivel 1 está desbloqueado por defecto
    }
  }

  // Generar un ID único para el dispositivo
  Future<String> _getDeviceId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? deviceId = prefs.getString(_deviceIdKey);
      
      if (deviceId == null) {
        // Generar un nuevo ID si no existe
        final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        final random = DateTime.now().toString();
        final bytes = utf8.encode(timestamp + random);
        deviceId = sha256.convert(bytes).toString();
        
        await prefs.setString(_deviceIdKey, deviceId);
        debugPrint('Nuevo ID de dispositivo generado: ${deviceId.substring(0, 10)}...');
      } else {
        debugPrint('ID de dispositivo existente: ${deviceId.substring(0, 10)}...');
      }
      
      return deviceId;
    } catch (e) {
      debugPrint('Error al generar ID de dispositivo: $e');
      // Generar un ID temporal en caso de error
      return DateTime.now().millisecondsSinceEpoch.toString();
    }
  }
  
  // Método para depuración - listar todas las suscripciones
  Future<List<Map<String, dynamic>>> getAllSubscriptions() async {
    try {
      // Si estamos en la web, usamos SharedPreferences
      if (kIsWeb) {
        return await _getAllSubscriptionsWithPrefs();
      }
      
      // En dispositivos móviles o de escritorio, usamos SQLite
      final db = await database;
      final List<Map<String, dynamic>> result = await db.query(_tableName);
      debugPrint('Total de suscripciones en SQLite: ${result.length}');
      return result;
    } catch (e) {
      debugPrint('Error al obtener suscripciones: $e');
      return [];
    }
  }
  
  // Obtener todas las suscripciones usando SharedPreferences (para Web)
  Future<List<Map<String, dynamic>>> _getAllSubscriptionsWithPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> keys = prefs.getStringList(_keysListKey) ?? [];
    final int unlockedLevel = prefs.getInt(_unlockedLevelKey) ?? 1;
    final String deviceId = await _getDeviceId();
    final now = DateTime.now();
    
    debugPrint('Total de suscripciones en SharedPreferences: ${keys.length}');
    
    return keys.map((key) {
      final int level = KeyGenerator.getLevelFromKey(key);
      return {
        'id': keys.indexOf(key),
        'key': key,
        'level': level,
        'activationDate': now.subtract(const Duration(days: 1)).toIso8601String(),
        'expiryDate': now.add(const Duration(days: 365)).toIso8601String(),
        'deviceId': deviceId,
      };
    }).toList();
  }
} 