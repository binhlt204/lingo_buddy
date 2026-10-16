import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/tts_helper.dart';
import '../../core/widgets/mascot_widget.dart';
import '../../data/models/word_model.dart';
import '../../data/services/srs_service.dart';

class FlashcardScreen extends StatefulWidget {
  final List<WordModel>? customWordList;
  final String title;

  const FlashcardScreen({
    super.key,
    this.customWordList,
    this.title = 'Thẻ Note B1',
  });

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen>
    with SingleTickerProviderStateMixin {
  late List<WordModel> _words;
  int _currentIndex = 0;
  bool _isFlipped = false;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _words = widget.customWordList ?? SrsService.instance.getDueWords();
    if (_words.isEmpty) {
      _words = SrsService.instance.getAllWords();
    }

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  Future<void> _handleAnswer(SrsRating rating) async {
    final currentWord = _words[_currentIndex];
    await SrsService.instance.answerCard(currentWord, rating);

    if (_currentIndex < _words.length - 1) {
      if (_isFlipped) {
        _flipController.reverse();
        _isFlipped = false;
      }
      setState(() {
        _currentIndex++;
      });
    } else {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MascotWidget(
              size: 110,
              mood: MascotMood.proud,
              speechBubbleText: 'Tuyệt vời lắm bạn ơi!',
            ),
            const SizedBox(height: 16),
            const Text(
              'Đã hoàn thành phiên học!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Bạn đã ôn luyện ${_words.length} thẻ ghi nhớ hôm nay. Mochi rất tự hào về bạn!',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSub,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Quay về trang chủ', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_words.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MascotWidget(
                size: 110,
                mood: MascotMood.happy,
                speechBubbleText: 'Hôm nay không có thẻ nào đến hạn!',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Quay lại'),
              ),
            ],
          ),
        ),
      );
    }

    final currentWord = _words[_currentIndex];
    final progress = (_currentIndex + 1) / _words.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(
              currentWord.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: currentWord.isBookmarked ? AppColors.secondary : AppColors.textSub,
            ),
            onPressed: () async {
              await SrsService.instance.toggleBookmark(currentWord.id);
              setState(() {
                currentWord.isBookmarked = !currentWord.isBookmarked;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // Progress Bar
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: AppColors.border,
                        valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${_currentIndex + 1}/${_words.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSub,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 3D Flip Card
              Expanded(
                child: GestureDetector(
                  onTap: _flipCard,
                  child: AnimatedBuilder(
                    animation: _flipAnimation,
                    builder: (context, child) {
                      final angle = _flipAnimation.value * math.pi;
                      final isFront = angle < math.pi / 2;

                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // perspective
                          ..rotateY(angle),
                        child: isFront
                            ? _buildFrontCard(currentWord)
                            : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..rotateY(math.pi),
                                child: _buildBackCard(currentWord),
                              ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // SRS Rating Buttons (Show when flipped or tap to flip hint)
              if (_isFlipped)
                Row(
                  children: [
                    Expanded(
                      child: _buildSrsButton(
                        label: 'Khó',
                        subtext: 'Ôn sớm',
                        color: AppColors.srsHard,
                        icon: Icons.refresh_rounded,
                        onTap: () => _handleAnswer(SrsRating.hard),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSrsButton(
                        label: 'Vừa',
                        subtext: 'Sau 1 ngày',
                        color: AppColors.srsMedium,
                        icon: Icons.check_circle_outline,
                        onTap: () => _handleAnswer(SrsRating.medium),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSrsButton(
                        label: 'Dễ',
                        subtext: 'Sau 3 ngày',
                        color: AppColors.srsEasy,
                        icon: Icons.sentiment_very_satisfied,
                        onTap: () => _handleAnswer(SrsRating.easy),
                      ),
                    ),
                  ],
                )
              else
                OutlinedButton.icon(
                  onPressed: _flipCard,
                  icon: const Icon(Icons.touch_app_outlined, size: 18),
                  label: const Text('Chạm thẻ để lật xem nghĩa & ví dụ'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSub,
                    side: const BorderSide(color: AppColors.border, width: 1.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFrontCard(WordModel word) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              word.topic.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const Spacer(),

          // Main English Word
          Text(
            word.word,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // IPA & Part of Speech
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                word.phonetic,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSub,
                  fontFamily: 'NotoSans',
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  word.partOfSpeech,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSub,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Pronounce Audio Button
          InkWell(
            onTap: () => TtsHelper.speak(word.word),
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.volume_up_rounded,
                color: AppColors.primary,
                size: 28,
              ),
            ),
          ),
          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.flip_to_back_rounded, size: 16, color: AppColors.textMuted),
              SizedBox(width: 6),
              Text(
                'Chạm để xem nghĩa',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard(WordModel word) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBF7),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.primary.withOpacity(0.35), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                word.word,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary, size: 24),
                onPressed: () => TtsHelper.speak(word.word),
              ),
            ],
          ),
          const Divider(height: 20, color: AppColors.border),

          // Meaning Vi
          const Text(
            'Ý NGHĨA (TIẾNG VIỆT)',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppColors.textMuted,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            word.meaningVi,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 22),

          // Example Sentence
          const Text(
            'VÍ DỤ TRONG NGỮ CẢNH B1',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppColors.textMuted,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '“${word.exampleEn}”',
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMain,
                          height: 1.4,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => TtsHelper.speak(word.exampleEn),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(Icons.play_circle_outline_rounded,
                            color: AppColors.secondary, size: 22),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  word.exampleVi,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSub,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),

          const Center(
            child: Text(
              'Chọn mức độ ghi nhớ để lưu vào lịch ôn tập',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSrsButton({
    required String label,
    required String subtext,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(0.4), width: 1.2),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              subtext,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
