import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPreferences? _prefs;
  static Future<SharedPreferences?> createSharedPreferences() async {
    SharedPrefsHelper._prefs ??= await SharedPreferences.getInstance();
    return SharedPrefsHelper._prefs;
  }

  static Future<void> setToken(String? token) async {
    await createSharedPreferences();
    await SharedPrefsHelper._prefs?.setString("token", token!);
  }

  static Future<String?> getToken() async {
    await createSharedPreferences();
    return SharedPrefsHelper._prefs?.getString("token") ?? "";
  }

  static Future<void> deleteToken() async {
    await createSharedPreferences();
    await SharedPrefsHelper._prefs?.remove("token");
  }
}
