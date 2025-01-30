import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  //bu blok sayesinde bir singleton oluşturduk ve shared preferences nesnesini oluşturduk
  //bu tekrar tekrar oluşumun önüne geçer performansı artırır
  static SharedPreferences? _prefs;
  static Future<SharedPreferences?> createSharedPreferences() async {
    SharedPrefsHelper._prefs ??= await SharedPreferences.getInstance();
    return SharedPrefsHelper._prefs;
  }

  static Future<void> setToken(String? comingToken) async {
    await createSharedPreferences();
    await SharedPrefsHelper._prefs?.setString("token", comingToken!);
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
