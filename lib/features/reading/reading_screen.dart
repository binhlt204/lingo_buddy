import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/tts_helper.dart';
import '../../data/models/reading_model.dart';
import '../../data/models/word_model.dart';
import '../../data/repositories/b1_data.dart';
import '../../data/services/srs_service.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final List<ReadingModel> _readings = B1Data.getInitialReadings();
  ReadingModel? _selectedReading;
  bool _showBilingual = false;

  void _openWordLookupModal(String wordKey, String meaning) {
    TtsHelper.speak(wordKey);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    wordKey,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary, size: 26),
                    onPressed: () => TtsHelper.speak(wordKey),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Từ vựng trọng tâm B1',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'NGHĨA TIẾNG VIỆT',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMuted),
              ),
              const SizedBox(height: 4),
              Text(
                meaning,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMain,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final newWord = WordModel(
                      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
                      word: wordKey,
                      phonetic: '',
                      partOfSpeech: 'B1',
                      meaningVi: meaning,
                      exampleEn: 'Example from reading: $_selectedReading?.title',
                      exampleVi: '',
                      topic: _selectedReading?.topic ?? 'Reading',
                      isBookmarked: true,
                    );
                    final messenger = ScaffoldMessenger.of(context);
                    await SrsService.instance.addCustomWord(newWord);
                    if (!mounted) return;
                    Navigator.of(context).pop();
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text('Đã thêm "$wordKey" vào Thẻ Note!'),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.note_add_rounded),
                  label: const Text('Thêm vào Thẻ Note ôn tập'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedReading != null) {
      return _buildReadingDetailView(_selectedReading!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đọc bài B1', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        itemCount: _readings.length,
        itemBuilder: (context, index) {
          final reading = _readings[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: AppColors.border),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedReading = reading;
                  _showBilingual = false;
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.menu_book_rounded, color: AppColors.primary, size: 26),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryLight,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  reading.topic,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${reading.readingTimeMinutes} phút đọc',
                                style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            reading.title,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMain,
                            ),
                          ),
                          Text(
                            reading.titleVi,
                            style: const TextStyle(fontSize: 13, color: AppColors.textSub),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textMuted),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildReadingDetailView(ReadingModel reading) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            TtsHelper.stop();
            setState(() {
              _selectedReading = null;
            });
          },
        ),
        title: Text(reading.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            tooltip: 'Đọc to toàn bài',
            icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary),
            onPressed: () => TtsHelper.speak(reading.contentEn),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Controls Bar: Bilingual toggle & hint
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.touch_app_outlined, size: 16, color: AppColors.primary),
                      SizedBox(width: 6),
                      Text(
                        'Chạm từ gạch chân để tra nghĩa',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Song ngữ',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSub),
                      ),
                      Switch(
                        value: _showBilingual,
                        activeThumbColor: AppColors.primary,
                        onChanged: (val) {
                          setState(() {
                            _showBilingual = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // English Text with Tap-to-Lookup
            _buildInteractiveEnglishText(reading),

            if (_showBilingual) ...[
              const SizedBox(height: 28),
              const Divider(color: AppColors.border, thickness: 1.2),
              const SizedBox(height: 12),
              const Text(
                'BẢN DỊCH TIẾNG VIỆT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                reading.contentVi,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.7,
                  color: AppColors.textSub,
                ),
              ),
            ],
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveEnglishText(ReadingModel reading) {
    final words = reading.contentEn.split(RegExp(r'(\s+)'));
    final spans = <InlineSpan>[];

    for (final rawToken in words) {
      final cleanWord = rawToken.replaceAll(RegExp(r'[^a-zA-Z]'), '').toLowerCase();

      if (reading.vocabularyGlossary.containsKey(cleanWord)) {
        final meaning = reading.vocabularyGlossary[cleanWord]!;
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: InkWell(
              onTap: () => _openWordLookupModal(cleanWord, meaning),
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.primary, width: 2.0),
                  ),
                ),
                child: Text(
                  rawToken,
                  style: const TextStyle(
                    fontSize: 16.5,
                    height: 1.7,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: rawToken,
            style: const TextStyle(
              fontSize: 16.5,
              height: 1.7,
              color: AppColors.textMain,
            ),
          ),
        );
      }
      spans.add(const TextSpan(text: ' '));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}
