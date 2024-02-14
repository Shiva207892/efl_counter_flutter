import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static Future<void> clearPreferences() async {
    final prefs = await getPrefs();
    await prefs.clear();
  }

  static Future<void> removeFromPreferences(String key) async {
    final prefs = await getPrefs();
    await prefs.remove(key);
  }

  static Future<void> setData(String key, String value) async {
    final prefs = await getPrefs();
    await prefs.setString(key, value);
  }

  static Future<String?> getStringData(String key) async {
    final prefs = await getPrefs();
    return prefs.getString(key);
  }

  static Future<void> setBool(String key, bool value) async {
    final prefs = await getPrefs();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await getPrefs();
    return prefs.getBool(key);
  }
}