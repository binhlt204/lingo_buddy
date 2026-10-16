import '../models/word_model.dart';
import '../models/reading_model.dart';

class B1Data {
  static List<WordModel> getInitialWords() {
    return [
      WordModel(
        id: 'w1',
        word: 'accomplish',
        phonetic: '/əˈkʌm.plɪʃ/',
        partOfSpeech: 'verb',
        meaningVi: 'hoàn thành, đạt được mục tiêu',
        exampleEn: 'She worked hard to accomplish her lifelong dream of studying abroad.',
        exampleVi: 'Cô ấy đã nỗ lực hết mình để hoàn thành ước mơ đi du học cả đời.',
        topic: 'Work & Career',
      ),
      WordModel(
        id: 'w2',
        word: 'convenient',
        phonetic: '/kənˈviː.ni.ənt/',
        partOfSpeech: 'adjective',
        meaningVi: 'tiện lợi, thuận tiện',
        exampleEn: 'Living near a subway station is very convenient for daily commuting.',
        exampleVi: 'Sống gần trạm tàu điện ngầm rất thuận tiện cho việc đi lại hàng ngày.',
        topic: 'Daily Life',
      ),
      WordModel(
        id: 'w3',
        word: 'persuade',
        phonetic: '/pəˈsweɪd/',
        partOfSpeech: 'verb',
        meaningVi: 'thuyết phục ai đó làm gì',
        exampleEn: 'He managed to persuade his manager to adopt the new flexible work policy.',
        exampleVi: 'Anh ấy đã thuyết phục được sếp áp dụng chính sách làm việc linh hoạt mới.',
        topic: 'Communication',
      ),
      WordModel(
        id: 'w4',
        word: 'essential',
        phonetic: '/ɪˈsen.ʃəl/',
        partOfSpeech: 'adjective',
        meaningVi: 'cốt lõi, thiết yếu, không thể thiếu',
        exampleEn: 'Good communication skills are essential in any collaborative project.',
        exampleVi: 'Kỹ năng giao tiếp tốt là điều thiết yếu trong bất kỳ dự án hợp tác nào.',
        topic: 'Skills',
      ),
      WordModel(
        id: 'w5',
        word: 'destination',
        phonetic: '/ˌdes.tɪˈneɪ.ʃən/',
        partOfSpeech: 'noun',
        meaningVi: 'điểm đến, đích đến',
        exampleEn: 'Da Nang is a popular destination for travelers looking for beautiful beaches.',
        exampleVi: 'Đà Nẵng là điểm đến nổi tiếng cho du khách tìm kiếm những bãi biển đẹp.',
        topic: 'Travel',
      ),
      WordModel(
        id: 'w6',
        word: 'hesitate',
        phonetic: '/ˈhez.ɪ.teɪt/',
        partOfSpeech: 'verb',
        meaningVi: 'ngập ngừng, do dự',
        exampleEn: 'Do not hesitate to ask questions if you do not understand the lesson.',
        exampleVi: 'Đừng do dự đặt câu hỏi nếu bạn không hiểu bài học nhé.',
        topic: 'Communication',
      ),
      WordModel(
        id: 'w7',
        word: 'opportunity',
        phonetic: '/ˌɒp.əˈtjuː.nə.ti/',
        partOfSpeech: 'noun',
        meaningVi: 'cơ hội, dịp may',
        exampleEn: 'Internships give students a valuable opportunity to gain practical experience.',
        exampleVi: 'Kỳ thực tập mang đến cho sinh viên cơ hội quý giá để tích lũy kinh nghiệm thực tế.',
        topic: 'Work & Career',
      ),
      WordModel(
        id: 'w8',
        word: 'sustainable',
        phonetic: '/səˈsteɪ.nə.bəl/',
        partOfSpeech: 'adjective',
        meaningVi: 'bền vững, thân thiện môi trường',
        exampleEn: 'Many companies are switching to sustainable packaging to reduce plastic waste.',
        exampleVi: 'Nhiều công ty đang chuyển sang bao bì bền vững để giảm thiểu rác thải nhựa.',
        topic: 'Environment',
      ),
      WordModel(
        id: 'w9',
        word: 'temporary',
        phonetic: '/ˈtem.pər.ər.i/',
        partOfSpeech: 'adjective',
        meaningVi: 'tạm thời, nhất thời',
        exampleEn: 'This inconvenience is only temporary while the road is being repaired.',
        exampleVi: 'Sự bất tiện này chỉ là tạm thời trong khi con đường đang được sửa chữa.',
        topic: 'Daily Life',
      ),
      WordModel(
        id: 'w10',
        word: 'recommend',
        phonetic: '/ˌrek.əˈmend/',
        partOfSpeech: 'verb',
        meaningVi: 'khuyên bảo, giới thiệu, gợi ý',
        exampleEn: 'Can you recommend a cozy cafe with good wifi where I can read books?',
        exampleVi: 'Bạn có thể gợi ý một quán cà phê ấm cúng có wifi tốt để mình đọc sách không?',
        topic: 'Daily Life',
      ),
      WordModel(
        id: 'w11',
        word: 'efficient',
        phonetic: '/ɪˈfɪʃ.ənt/',
        partOfSpeech: 'adjective',
        meaningVi: 'có hiệu suất cao, tiết kiệm thời gian',
        exampleEn: 'The new digital filing system makes our workflow much more efficient.',
        exampleVi: 'Hệ thống lưu trữ số mới giúp quy trình làm việc hiệu quả hơn rất nhiều.',
        topic: 'Work & Career',
      ),
      WordModel(
        id: 'w12',
        word: 'curious',
        phonetic: '/ˈkjʊə.ri.əs/',
        partOfSpeech: 'adjective',
        meaningVi: 'tò mò, thích khám phá học hỏi',
        exampleEn: 'Children are naturally curious about the world around them.',
        exampleVi: 'Trẻ em vốn có tính tò mò tự nhiên về thế giới xung quanh.',
        topic: 'Psychology',
      ),
    ];
  }

  static List<ReadingModel> getInitialReadings() {
    return [
      const ReadingModel(
        id: 'r1',
        title: 'The Art of Slow Living',
        titleVi: 'Nghệ thuật Sống Chậm',
        topic: 'Lifestyle',
        readingTimeMinutes: 2,
        vocabularyGlossary: {
          'accomplish': 'hoàn thành, đạt được',
          'convenient': 'tiện lợi, thuận tiện',
          'essential': 'thiết yếu, cốt lõi',
          'sustainable': 'bền vững',
          'hesitate': 'do dự, ngập ngừng',
        },
        contentEn:
            'In modern society, many people believe that working fast is essential to accomplish success. However, slow living teaches us that taking small breaks is equally important.\n\n'
            'Living slowly does not mean being lazy. Instead, it means being mindful of what matters most. For instance, enjoying a warm cup of tea without checking emails is a simple habit. Many people hesitate to slow down because they worry about falling behind.\n\n'
            'When you build a sustainable routine, you become more focused and peaceful. Do not hesitate to give yourself quiet moments every day.',
        contentVi:
            'Trong xã hội hiện đại, nhiều người tin rằng làm việc nhanh là điều thiết yếu để đạt được thành công. Tuy nhiên, lối sống chậm dạy chúng ta rằng những khoảng nghỉ ngắn cũng quan trọng không kém.\n\n'
            'Sống chậm không có nghĩa là lười biếng. Thay vào đó, nó có nghĩa là ý thức về những điều quan trọng nhất. Ví dụ, thưởng thức một tách trà ấm mà không cần kiểm tra email là một thói quen giản dị. Nhiều người ngập ngừng khi sống chậm lại vì họ sợ bị tụt lại phía sau.\n\n'
            'Khi bạn xây dựng một lối sống bền vững, bạn sẽ trở nên tập trung và bình an hơn. Đừng ngần ngại cho bản thân những khoảnh khắc yên tĩnh mỗi ngày.',
      ),
      const ReadingModel(
        id: 'r2',
        title: 'Traveling Solo for the First Time',
        titleVi: 'Lần Đầu Đi Du Lịch Một Mình',
        topic: 'Travel & Growth',
        readingTimeMinutes: 3,
        vocabularyGlossary: {
          'destination': 'điểm đến',
          'opportunity': 'cơ hội quý giá',
          'curious': 'tò mò, hiếu kỳ',
          'recommend': 'gợi ý, khuyên',
          'convenient': 'tiện lợi',
        },
        contentEn:
            'Choosing your first solo destination can feel both exciting and frightening. Last summer, Linh decided to travel alone to Da Lat.\n\n'
            'At first, she wondered if she could manage everything on her own. But it turned out to be an amazing opportunity to learn self-reliance. She stayed at a convenient homestay near the pine forest.\n\n'
            'Being curious about local culture, she visited morning flower markets and talked with local farmers. She would recommend solo travel to anyone who wants to discover their own inner strength.',
        contentVi:
            'Lựa chọn điểm đến đầu tiên cho chuyến đi một mình có thể vừa hào hứng vừa hơi lo sợ. Mùa hè năm ngoái, Linh quyết định đi du lịch một mình lên Đà Lạt.\n\n'
            'Ban đầu, cô tự hỏi liệu mình có thể tự xoay xở mọi thứ không. Nhưng hóa ra đó là một cơ hội tuyệt vời để rèn luyện tính tự lập. Cô ở tại một homestay tiện lợi gần rừng thông.\n\n'
            'Với tính tò mò muốn tìm hiểu văn hóa bản địa, cô ghé thăm các chợ hoa buổi sớm và trò chuyện với người nông dân. Cô khuyên bất kỳ ai muốn khám phá sức mạnh nội tâm đều nên thử đi du lịch một mình.',
      ),
    ];
  }
}
