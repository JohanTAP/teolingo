import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  factory AudioService() {
    return _instance;
  }
  
  AudioService._internal();
  
  Future<void> playAudio(String audioPath) async {
    try {
      await _audioPlayer.setAsset(audioPath);
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Error al reproducir el audio: $e');
    }
  }
  
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
} 