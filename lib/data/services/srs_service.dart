import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/word_model.dart';
import '../repositories/b1_data.dart';

enum SrsRating { hard, medium, easy }

class SrsService {
  static const String _wordsKey = 'lingobuddy_words_v1';
  static const String _streakKey = 'lingobuddy_streak_v1';
  static const String _lastStudyDateKey = 'lingobuddy_last_date_v1';

  static final SrsService instance = SrsService._internal();
  SrsService._internal();

  List<WordModel> _words = [];
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_wordsKey);

    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List<dynamic> list = jsonDecode(jsonString);
        _words = list.map((e) => WordModel.fromJson(e)).toList();
      } catch (_) {
        _words = B1Data.getInitialWords();
        await _saveToDisk();
      }
    } else {
      _words = B1Data.getInitialWords();
      await _saveToDisk();
    }

    _updateStreak(prefs);
    _isInitialized = true;
  }

  List<WordModel> getAllWords() => List.unmodifiable(_words);

  List<WordModel> getDueWords() {
    final now = DateTime.now();
    return _words.where((w) {
      return w.nextReviewDate.isBefore(now) ||
          w.nextReviewDate.difference(now).inHours <= 4;
    }).toList();
  }

  List<WordModel> getBookmarkedWords() {
    return _words.where((w) => w.isBookmarked).toList();
  }

  Future<void> answerCard(WordModel word, SrsRating rating) async {
    final now = DateTime.now();

    switch (rating) {
      case SrsRating.hard:
        word.repetitions = 0;
        word.intervalDays = 0;
        word.easeFactor = (word.easeFactor - 0.20).clamp(1.3, 3.0);
        word.nextReviewDate = now.add(const Duration(minutes: 10)); // review soon
        break;

      case SrsRating.medium:
        if (word.repetitions == 0) {
          word.intervalDays = 1;
        } else if (word.repetitions == 1) {
          word.intervalDays = 3;
        } else {
          word.intervalDays = (word.intervalDays * word.easeFactor).round();
        }
        word.repetitions += 1;
        word.nextReviewDate = now.add(Duration(days: word.intervalDays));
        break;

      case SrsRating.easy:
        if (word.repetitions == 0) {
          word.intervalDays = 3;
        } else if (word.repetitions == 1) {
          word.intervalDays = 7;
        } else {
          word.intervalDays = (word.intervalDays * word.easeFactor * 1.3).round();
        }
        word.repetitions += 1;
        word.easeFactor = (word.easeFactor + 0.15).clamp(1.3, 3.0);
        word.nextReviewDate = now.add(Duration(days: word.intervalDays));
        break;
    }

    await _saveToDisk();
  }

  Future<void> toggleBookmark(String wordId) async {
    final index = _words.indexWhere((w) => w.id == wordId);
    if (index != -1) {
      _words[index].isBookmarked = !_words[index].isBookmarked;
      await _saveToDisk();
    }
  }

  Future<void> addCustomWord(WordModel word) async {
    _words.insert(0, word);
    await _saveToDisk();
  }

  Future<int> getStreakDays() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_streakKey) ?? 1;
  }

  void _updateStreak(SharedPreferences prefs) {
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month}-${today.day}';
    final lastStr = prefs.getString(_lastStudyDateKey);

    if (lastStr == null) {
      prefs.setString(_lastStudyDateKey, todayStr);
      prefs.setInt(_streakKey, 1);
      return;
    }

    if (lastStr != todayStr) {
      final parts = lastStr.split('-').map(int.parse).toList();
      final lastDate = DateTime(parts[0], parts[1], parts[2]);
      final diffDays = today.difference(lastDate).inDays;

      if (diffDays == 1) {
        final currentStreak = prefs.getInt(_streakKey) ?? 1;
        prefs.setInt(_streakKey, currentStreak + 1);
      } else if (diffDays > 1) {
        prefs.setInt(_streakKey, 1);
      }
      prefs.setString(_lastStudyDateKey, todayStr);
    }
  }

  Future<void> _saveToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_words.map((w) => w.toJson()).toList());
    await prefs.setString(_wordsKey, jsonString);
  }
}
