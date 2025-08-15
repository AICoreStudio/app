import 'package:shared_preferences/shared_preferences.dart';
import 'package:starweaver/models/zodiac_sign.dart';

class StorageService {
  static const String _birthdateKey = 'birthdate';
  static const String _zodiacSignKey = 'zodiac_sign';

  static Future<void> saveBirthdate(DateTime birthdate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_birthdateKey, birthdate.toIso8601String());
    
    final zodiacSign = ZodiacSign.getSignByDate(birthdate);
    await prefs.setString(_zodiacSignKey, zodiacSign.name);
  }

  static Future<DateTime?> getBirthdate() async {
    final prefs = await SharedPreferences.getInstance();
    final birthdateString = prefs.getString(_birthdateKey);
    if (birthdateString != null) {
      return DateTime.parse(birthdateString);
    }
    return null;
  }

  static Future<ZodiacSign?> getSavedZodiacSign() async {
    final prefs = await SharedPreferences.getInstance();
    final signName = prefs.getString(_zodiacSignKey);
    if (signName != null) {
      return ZodiacSign.signs.firstWhere(
        (sign) => sign.name == signName,
        orElse: () => ZodiacSign.signs.first,
      );
    }
    return null;
  }

  static Future<bool> hasUserData() async {
    final birthdate = await getBirthdate();
    return birthdate != null;
  }
}