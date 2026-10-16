class ReadingModel {
  final String id;
  final String title;
  final String titleVi;
  final String topic;
  final String contentEn;
  final String contentVi;
  final int readingTimeMinutes;
  final Map<String, String> vocabularyGlossary; // word -> meaningVi

  const ReadingModel({
    required this.id,
    required this.title,
    required this.titleVi,
    required this.topic,
    required this.contentEn,
    required this.contentVi,
    required this.readingTimeMinutes,
    required this.vocabularyGlossary,
  });
}
