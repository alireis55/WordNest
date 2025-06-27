import 'package:word_nest/core/services/http_service.dart';
import 'package:word_nest/core/services/routes/route.dart';
import 'package:word_nest/core/models/request/request_register_model.dart';
import 'package:word_nest/core/models/response/response_register_model.dart';
import 'dart:convert';

class RegisterService {
  static Future<ResponseRegisterModel> register(
      RequestRegisterModel model) async {
    try {
      final response = await HttpBase.post(Routa.registerUrl, model.toJson());
      if (response.statusCode == 200) {
        return ResponseRegisterModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400 || response.statusCode == 409) {
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
