import 'package:flutter_tts/flutter_tts.dart';

class TtsHelper {
  static final FlutterTts _flutterTts = FlutterTts();
  static bool _isInit = false;

  static Future<void> init() async {
    if (_isInit) return;
    try {
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.setSpeechRate(0.48); // Natural conversational speed
      await _flutterTts.setPitch(1.0);
      _isInit = true;
    } catch (_) {
      // Fallback if platform does not support TTS directly
    }
  }

  static Future<void> speak(String text) async {
    await init();
    try {
      await _flutterTts.stop();
      await _flutterTts.speak(text);
    } catch (_) {}
  }

  static Future<void> stop() async {
    try {
      await _flutterTts.stop();
    } catch (_) {}
  }
}
