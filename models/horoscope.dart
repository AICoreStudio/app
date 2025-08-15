class Horoscope {
  final String period;
  final String text;
  final String love;
  final String career;
  final String health;
  final int rating;

  const Horoscope({
    required this.period,
    required this.text,
    required this.love,
    required this.career,
    required this.health,
    required this.rating,
  });

  factory Horoscope.fromJson(Map<String, dynamic> json) {
    return Horoscope(
      period: json['period'] ?? 'today',
      text: json['text'] ?? '',
      love: json['love'] ?? '',
      career: json['career'] ?? '',
      health: json['health'] ?? '',
      rating: json['rating'] ?? 5,
    );
  }
}