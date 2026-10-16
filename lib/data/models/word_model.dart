class WordModel {
  final String id;
  final String word;
  final String phonetic;
  final String partOfSpeech; // n, v, adj, adv
  final String meaningVi;
  final String exampleEn;
  final String exampleVi;
  final String topic;
  final String note;
  bool isBookmarked;

  // SRS properties
  int repetitions;
  int intervalDays;
  double easeFactor;
  DateTime nextReviewDate;

  WordModel({
    required this.id,
    required this.word,
    required this.phonetic,
    required this.partOfSpeech,
    required this.meaningVi,
    required this.exampleEn,
    required this.exampleVi,
    required this.topic,
    this.note = '',
    this.isBookmarked = false,
    this.repetitions = 0,
    this.intervalDays = 0,
    this.easeFactor = 2.5,
    DateTime? nextReviewDate,
  }) : nextReviewDate = nextReviewDate ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'word': word,
        'phonetic': phonetic,
        'partOfSpeech': partOfSpeech,
        'meaningVi': meaningVi,
        'exampleEn': exampleEn,
        'exampleVi': exampleVi,
        'topic': topic,
        'note': note,
        'isBookmarked': isBookmarked,
        'repetitions': repetitions,
        'intervalDays': intervalDays,
        'easeFactor': easeFactor,
        'nextReviewDate': nextReviewDate.toIso8601String(),
      };

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
        id: json['id'],
        word: json['word'],
        phonetic: json['phonetic'] ?? '',
        partOfSpeech: json['partOfSpeech'] ?? '',
        meaningVi: json['meaningVi'],
        exampleEn: json['exampleEn'],
        exampleVi: json['exampleVi'],
        topic: json['topic'] ?? 'Chung',
        note: json['note'] ?? '',
        isBookmarked: json['isBookmarked'] ?? false,
        repetitions: json['repetitions'] ?? 0,
        intervalDays: json['intervalDays'] ?? 0,
        easeFactor: (json['easeFactor'] as num?)?.toDouble() ?? 2.5,
        nextReviewDate: json['nextReviewDate'] != null
            ? DateTime.parse(json['nextReviewDate'])
            : DateTime.now(),
      );
}
