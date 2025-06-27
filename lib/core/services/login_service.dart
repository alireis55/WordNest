import 'package:word_nest/core/services/http_service.dart';
import 'package:word_nest/core/services/routes/route.dart';
import 'package:word_nest/core/models/request/request_login_model.dart';
import 'package:word_nest/core/models/response/response_login_model.dart';
import 'dart:convert';

class LoginService {
  static Future<ResponseLoginModel> login(RequestLoginModel model) async {
    try {
      final response = await HttpBase.post(Routa.loginUrl, model.toJson());
      if (response.statusCode == 200) {
        return ResponseLoginModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400 ||
          response.statusCode == 401 ||
          response.statusCode == 409) {
        throw Exception(
            jsonDecode(response.body)['message'] ?? 'undefined Error');
      } else {
        throw Exception('undefined Error');
      }
    } catch (e) {
      throw Exception('undefined Error');
    }
  }
}
