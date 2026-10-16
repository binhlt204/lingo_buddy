import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/tts_helper.dart';

class PracticeScreen extends StatefulWidget {
  final int initialTab; // 0: Speaking, 1: Writing
  const PracticeScreen({super.key, this.initialTab = 0});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _writingController = TextEditingController();
  bool _isSpeakingSubmitted = false;

  final String _speakingPrompt =
      'In my opinion, living near a subway station is convenient for daily commuting.';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _writingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Luyện Nói & Viết B1', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSub,
          tabs: const [
            Tab(icon: Icon(Icons.mic_rounded), text: 'Nói (Shadowing)'),
            Tab(icon: Icon(Icons.edit_note_rounded), text: 'Viết (Guided Writing)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSpeakingTab(),
          _buildWritingTab(),
        ],
      ),
    );
  }

  Widget _buildSpeakingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                const Text(
                  'NGHE CÂU MẪU & LẶP LẠI (SHADOWING)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMuted,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  '“$_speakingPrompt”',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMain,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Theo tôi, sống gần trạm tàu điện ngầm rất tiện lợi cho việc đi lại hàng ngày.',
                  style: TextStyle(fontSize: 13, color: AppColors.textSub, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                IconButton.filled(
                  iconSize: 32,
                  style: IconButton.styleFrom(backgroundColor: AppColors.primaryLight),
                  icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary),
                  onPressed: () => TtsHelper.speak(_speakingPrompt),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSpeakingSubmitted = true;
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary.withOpacity(0.35),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.mic_rounded, color: Colors.white, size: 40),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Chạm để ghi âm giọng nói của bạn',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSub),
                ),
              ],
            ),
          ),

          if (_isSpeakingSubmitted) ...[
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: const [
                  Icon(Icons.stars_rounded, color: AppColors.primary, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Rất tốt! Ngữ điệu và phát âm từ "convenient" & "commuting" đạt chuẩn B1 (92%)!',
                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWritingTab() {
    final wordsCount = _writingController.text.trim().isEmpty
        ? 0
        : _writingController.text.trim().split(RegExp(r'\s+')).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'ĐỀ BÀI VIẾT B1 (EMAIL / ĐOẠN VĂN)',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.secondary),
                ),
                SizedBox(height: 6),
                Text(
                  'Viết một email ngắn (40-60 từ) gửi cho bạn bè để gợi ý một địa điểm du lịch bạn vừa khám phá.',
                  style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: AppColors.textMain),
                ),
                SizedBox(height: 8),
                Text(
                  'Gợi ý cấu trúc: "I would recommend...", "It is a convenient place...", "You will not hesitate to..."',
                  style: TextStyle(fontSize: 12, color: AppColors.textSub),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _writingController,
            maxLines: 6,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Dear Linh,\nI want to recommend Da Lat to you...',
              hintStyle: const TextStyle(fontSize: 14, color: AppColors.textMuted),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Số từ: $wordsCount / 60 từ',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSub),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đoạn văn của bạn đã được lưu lại thành công!'),
                      backgroundColor: AppColors.primary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Nộp bài viết'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
