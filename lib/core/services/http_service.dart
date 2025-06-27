import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpBase {
  static Future<http.Response> post(
      String url, Map<String, dynamic> body) async {
    return await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body));
  }

  static Future<http.Response> get(String url) async {
    return await http.get(Uri.parse(url));
  }

  static Future<http.Response> getWithToken(String url, String token) async {
    return await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
  }
}
