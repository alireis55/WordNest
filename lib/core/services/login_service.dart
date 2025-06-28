import 'dart:developer';
import 'package:word_nest/core/services/http_service.dart';
import 'package:word_nest/core/services/routes/route.dart';
import 'package:word_nest/core/models/request/request_login_model.dart';
import 'package:word_nest/core/models/response/response_login_model.dart';
import 'dart:convert';
import 'package:word_nest/core/errors/custom_exception.dart';

class LoginService {
  static Future<ResponseLoginModel> login(RequestLoginModel model) async {
    try {
      final response = await HttpBase.post(Routa.loginUrl, model.toJson());
      final body = ResponseLoginModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        return body;
      }

      throw CustomException(response.statusCode);
    } on CustomException catch (e, stackTrace) {
      log('LoginService error: $e', stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      log('LoginService error: $e', stackTrace: stackTrace);
      throw CustomException(-1);
    }
  }
}
