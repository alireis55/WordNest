import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  //bu blok sayesinde bir singleton oluşturduk ve shared preferences nesnesini oluşturduk
  //bu tekrar tekrar oluşumun önüne geçer performansı artırır
  static SharedPreferences? _prefs;
  static Future<SharedPreferences?> createSharedPreferences() async {
    if (SharedPrefsHelper._prefs == null) {
      SharedPrefsHelper._prefs = await SharedPreferences.getInstance();
    } else {
      return SharedPrefsHelper._prefs;
    }
  }
  static Future<void> setToken(String? comingToken) async {
    await SharedPrefsHelper._prefs?.setString("token", comingToken! );
  } 

  static String? getToken() {
    return SharedPrefsHelper._prefs?.getString("token");
  }

  static Future<void> deleteToken() async{
    await SharedPrefsHelper._prefs?.remove("token");
  }
}

