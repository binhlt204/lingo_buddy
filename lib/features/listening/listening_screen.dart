import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/tts_helper.dart';

class ListeningScreen extends StatefulWidget {
  const ListeningScreen({super.key});

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  double _speed = 1.0;
  bool _isPlaying = false;
  final TextEditingController _answerController = TextEditingController();
  bool? _isCorrect;

  final String _sentence = 'Good communication skills are essential to accomplish success.';
  final String _missingWord = 'essential';

  void _playAudio() async {
    setState(() => _isPlaying = true);
    await TtsHelper.speak(_sentence);
    setState(() => _isPlaying = false);
  }

  void _checkAnswer() {
    final userText = _answerController.text.trim().toLowerCase();
    setState(() {
      _isCorrect = userText == _missingWord.toLowerCase();
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Luyện Nghe B1', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Audio Player Box
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.headphones_rounded, color: AppColors.secondary, size: 36),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Bài nghe: Giao tiếp nơi công sở',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Hãy bấm nghe và điền từ còn thiếu vào chỗ trống',
                    style: TextStyle(fontSize: 13, color: AppColors.textSub),
                  ),
                  const SizedBox(height: 20),

                  // Play Button & Speed
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Speed buttons
                      _buildSpeedChip(0.8),
                      const SizedBox(width: 8),
                      _buildSpeedChip(1.0),
                      const SizedBox(width: 8),
                      _buildSpeedChip(1.2),
                    ],
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton.icon(
                    onPressed: _playAudio,
                    icon: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 28),
                    label: Text(_isPlaying ? 'Đang phát...' : 'Phát âm thanh'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Dictation Exercise Card
            const Text(
              'BÀI TẬP ĐIỀN TỪ (DICTATION)',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textMuted,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '“Good communication skills are [ ... ] to accomplish success.”',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMain,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _answerController,
                    decoration: InputDecoration(
                      hintText: 'Nhập từ nghe được vào đây...',
                      hintStyle: const TextStyle(fontSize: 14, color: AppColors.textMuted),
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _checkAnswer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text('Kiểm tra đáp án', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      if (_isCorrect != null)
                        Row(
                          children: [
                            Icon(
                              _isCorrect! ? Icons.check_circle_rounded : Icons.cancel_rounded,
                              color: _isCorrect! ? AppColors.srsEasy : AppColors.srsHard,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _isCorrect! ? 'Chính xác! (+10 XP)' : 'Chưa đúng, hãy nghe lại nhé!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _isCorrect! ? AppColors.srsEasy : AppColors.srsHard,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedChip(double val) {
    final isSelected = _speed == val;
    return ChoiceChip(
      label: Text('${val}x'),
      selected: isSelected,
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.textSub,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      onSelected: (_) {
        setState(() {
          _speed = val;
        });
      },
    );
  }
}
