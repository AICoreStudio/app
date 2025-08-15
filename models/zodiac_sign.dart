class ZodiacSign {
  final String name;
  final String nameRu;
  final String symbol;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String element;
  final String planet;
  final String emoji;

  ZodiacSign({
    required this.name,
    required this.nameRu,
    required this.symbol,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.element,
    required this.planet,
    required this.emoji,
  });

  static final List<ZodiacSign> signs = [
    ZodiacSign(
      name: 'Aries',
      nameRu: 'Овен',
      symbol: '♈',
      startDate: DateTime(2024, 3, 21),
      endDate: DateTime(2024, 4, 19),
      description: 'Энергичный, амбициозный и прирожденный лидер. Овны любят быть первыми и не боятся вызовов.',
      element: 'Огонь',
      planet: 'Марс',
      emoji: '🐏',
    ),
    ZodiacSign(
      name: 'Taurus',
      nameRu: 'Телец',
      symbol: '♉',
      startDate: DateTime(2024, 4, 20),
      endDate: DateTime(2024, 5, 20),
      description: 'Надежный, практичный и любит комфорт. Тельцы ценят стабильность и красоту.',
      element: 'Земля',
      planet: 'Венера',
      emoji: '🐂',
    ),
    ZodiacSign(
      name: 'Gemini',
      nameRu: 'Близнецы',
      symbol: '♊',
      startDate: DateTime(2024, 5, 21),
      endDate: DateTime(2024, 6, 20),
      description: 'Коммуникативный, любознательный и адаптивный. Близнецы обладают быстрым умом и любят общение.',
      element: 'Воздух',
      planet: 'Меркурий',
      emoji: '👯',
    ),
    ZodiacSign(
      name: 'Cancer',
      nameRu: 'Рак',
      symbol: '♋',
      startDate: DateTime(2024, 6, 21),
      endDate: DateTime(2024, 7, 22),
      description: 'Чувствительный, заботливый и интуитивный. Раки глубоко привязаны к семье и дому.',
      element: 'Вода',
      planet: 'Луна',
      emoji: '🦀',
    ),
    ZodiacSign(
      name: 'Leo',
      nameRu: 'Лев',
      symbol: '♌',
      startDate: DateTime(2024, 7, 23),
      endDate: DateTime(2024, 8, 22),
      description: 'Гордый, щедрый и харизматичный. Львы естественные лидеры и любят быть в центре внимания.',
      element: 'Огонь',
      planet: 'Солнце',
      emoji: '🦁',
    ),
    ZodiacSign(
      name: 'Virgo',
      nameRu: 'Дева',
      symbol: '♍',
      startDate: DateTime(2024, 8, 23),
      endDate: DateTime(2024, 9, 22),
      description: 'Методичный, аналитический и заботливый. Девы стремятся к совершенству и помогают другим.',
      element: 'Земля',
      planet: 'Меркурий',
      emoji: '👸',
    ),
    ZodiacSign(
      name: 'Libra',
      nameRu: 'Весы',
      symbol: '♎',
      startDate: DateTime(2024, 9, 23),
      endDate: DateTime(2024, 10, 22),
      description: 'Дипломатичный, очаровательный и справедливый. Весы ищут баланс и гармонию во всем.',
      element: 'Воздух',
      planet: 'Венера',
      emoji: '⚖️',
    ),
    ZodiacSign(
      name: 'Scorpio',
      nameRu: 'Скорпион',
      symbol: '♏',
      startDate: DateTime(2024, 10, 23),
      endDate: DateTime(2024, 11, 21),
      description: 'Интенсивный, страстный и загадочный. Скорпионы обладают сильной интуицией и решимостью.',
      element: 'Вода',
      planet: 'Плутон',
      emoji: '🦂',
    ),
    ZodiacSign(
      name: 'Sagittarius',
      nameRu: 'Стрелец',
      symbol: '♐',
      startDate: DateTime(2024, 11, 22),
      endDate: DateTime(2024, 12, 21),
      description: 'Оптимистичный, независимый и философский. Стрельцы любят приключения и поиск истины.',
      element: 'Огонь',
      planet: 'Юпитер',
      emoji: '🏹',
    ),
    ZodiacSign(
      name: 'Capricorn',
      nameRu: 'Козерог',
      symbol: '♑',
      startDate: DateTime(2024, 12, 22),
      endDate: DateTime(2024, 12, 31),
      description: 'Амбициозный, дисциплинированный и практичный. Козероги нацелены на достижение своих целей.',
      element: 'Земля',
      planet: 'Сатурн',
      emoji: '🐐',
    ),
    ZodiacSign(
      name: 'Capricorn',
      nameRu: 'Козерог',
      symbol: '♑',
      startDate: DateTime(2024, 1, 1),
      endDate: DateTime(2024, 1, 19),
      description: 'Амбициозный, дисциплинированный и практичный. Козероги нацелены на достижение своих целей.',
      element: 'Земля',
      planet: 'Сатурн',
      emoji: '🐐',
    ),
    ZodiacSign(
      name: 'Aquarius',
      nameRu: 'Водолей',
      symbol: '♒',
      startDate: DateTime(2024, 1, 20),
      endDate: DateTime(2024, 2, 18),
      description: 'Инновационный, независимый и гуманитарный. Водолеи мыслят прогрессивно и ценят свободу.',
      element: 'Воздух',
      planet: 'Уран',
      emoji: '🏺',
    ),
    ZodiacSign(
      name: 'Pisces',
      nameRu: 'Рыбы',
      symbol: '♓',
      startDate: DateTime(2024, 2, 19),
      endDate: DateTime(2024, 3, 20),
      description: 'Мечтательный, сострадательный и творческий. Рыбы обладают богатым воображением и эмпатией.',
      element: 'Вода',
      planet: 'Нептун',
      emoji: '🐟',
    ),
  ];

  static ZodiacSign getSignByDate(DateTime birthDate) {
    final month = birthDate.month;
    final day = birthDate.day;
    
    for (final sign in signs) {
      if ((month == sign.startDate.month && day >= sign.startDate.day) ||
          (month == sign.endDate.month && day <= sign.endDate.day) ||
          (sign.startDate.month > sign.endDate.month && 
           (month == sign.startDate.month && day >= sign.startDate.day ||
            month == sign.endDate.month && day <= sign.endDate.day))) {
        return sign;
      }
    }
    
    return signs.first;
  }
}