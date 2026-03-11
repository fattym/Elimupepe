import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  static const String _imgKey = 'profile_img';
  static const String _nameKey = 'profile_name';
  static const String _bioKey = 'profile_bio';

  static Future<void> saveProfile(
    String imgPath,
    String name,
    String bio,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_imgKey, imgPath);
    await prefs.setString(_nameKey, name);
    await prefs.setString(_bioKey, bio);
  }

  static Future<Map<String, String?>> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'img': prefs.getString(_imgKey),
      'name': prefs.getString(_nameKey),
      'bio': prefs.getString(_bioKey),
    };
  }
}
