import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/tts_helper.dart';
import '../../core/widgets/mascot_widget.dart';
import '../../data/services/srs_service.dart';
import '../flashcards/flashcard_screen.dart';
import '../reading/reading_screen.dart';
import '../listening/listening_screen.dart';
import '../practice/practice_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _streakDays = 1;
  int _dueCardsCount = 0;
  int _totalWordsCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await SrsService.instance.init();
    final streak = await SrsService.instance.getStreakDays();
    final dueWords = SrsService.instance.getDueWords();
    final allWords = SrsService.instance.getAllWords();

    if (mounted) {
      setState(() {
        _streakDays = streak;
        _dueCardsCount = dueWords.length;
        _totalWordsCount = allWords.length;
        _isLoading = false;
      });
    }
  }

  void _showAllVocabularyModal() {
    final words = SrsService.instance.getAllWords();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          expand: false,
          builder: (_, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kho từ vựng B1',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textMain),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${words.length} từ',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: words.length,
                      separatorBuilder: (context, index) => const Divider(color: AppColors.border, height: 1),
                      itemBuilder: (context, index) {
                        final w = words[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 6),
                          title: Row(
                            children: [
                              Text(
                                w.word,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                w.phonetic,
                                style: const TextStyle(fontSize: 13, color: AppColors.textSub),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            w.meaningVi,
                            style: const TextStyle(fontSize: 14, color: AppColors.textMain),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary),
                            onPressed: () => TtsHelper.speak(w.word),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar: Mascot Greeting & Streak
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const MascotWidget(
                        size: 52,
                        mood: MascotMood.happy,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Chào bạn!',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSub,
                            ),
                          ),
                          Text(
                            'LingoBuddy B1',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMain,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Streak Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.local_fire_department_rounded, color: AppColors.secondary, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '$_streakDays ngày',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Main Daily Goal & SRS Action Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5A8E6B), Color(0xFF437053)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF437053).withOpacity(0.25),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Mục tiêu hôm nay',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        Text(
                          '$_dueCardsCount thẻ cần ôn',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Ôn tập Lặp lại Ngắt quãng',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Ghi nhớ sâu từ vựng B1 theo chu kỳ trí nhớ não bộ.',
                      style: TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FlashcardScreen(title: 'Ôn tập hôm nay'),
                          ),
                        );
                        _loadData();
                      },
                      icon: const Icon(Icons.play_arrow_rounded, color: AppColors.primaryDark),
                      label: const Text(
                        'Bắt đầu ôn bài ngay',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              // 4 Core Skills Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '4 Kỹ Năng Trọng Tâm B1',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                  TextButton(
                    onPressed: _showAllVocabularyModal,
                    child: const Text('Kho từ vựng', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // 4 Skills Grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildSkillCard(
                    title: 'Đọc bài',
                    subtitle: 'Chạm tra từ & song ngữ',
                    icon: Icons.menu_book_rounded,
                    color: const Color(0xFF65A07F),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ReadingScreen()),
                      );
                    },
                  ),
                  _buildSkillCard(
                    title: 'Luyện Nghe',
                    subtitle: 'Dictation & chỉnh tốc độ',
                    icon: Icons.headphones_rounded,
                    color: const Color(0xFFE58763),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ListeningScreen()),
                      );
                    },
                  ),
                  _buildSkillCard(
                    title: 'Luyện Nói',
                    subtitle: 'Shadowing phát âm B1',
                    icon: Icons.record_voice_over_rounded,
                    color: const Color(0xFF6B9AC4),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PracticeScreen(initialTab: 0)),
                      );
                    },
                  ),
                  _buildSkillCard(
                    title: 'Luyện Viết',
                    subtitle: 'Cấu trúc & email B1',
                    icon: Icons.edit_note_rounded,
                    color: const Color(0xFF9E84B0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PracticeScreen(initialTab: 1)),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Flashcard Quick Deck Entry
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.style_rounded, color: AppColors.primary, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tất cả Thẻ Note B1',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textMain),
                          ),
                          Text(
                            '$_totalWordsCount từ vựng đã nạp sẵn kèm IPA & ví dụ',
                            style: const TextStyle(fontSize: 12.5, color: AppColors.textSub),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: AppColors.textMuted),
                      onPressed: () async {
                        final all = SrsService.instance.getAllWords();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FlashcardScreen(
                              customWordList: all,
                              title: 'Toàn bộ từ vựng B1',
                            ),
                          ),
                        );
                        _loadData();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: const BorderSide(color: AppColors.border, width: 1.2),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: AppColors.textSub,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
