import 'dart:developer';

import 'package:word_nest/core/services/http_service.dart';
import 'package:word_nest/core/services/routes/route.dart';
import 'package:word_nest/core/models/request/request_register_model.dart';
import 'package:word_nest/core/models/response/response_register_model.dart';
import 'dart:convert';
import 'package:word_nest/core/errors/custom_exception.dart';

class RegisterService {
  static Future<ResponseRegisterModel> register(
      RequestRegisterModel model) async {
    try {
      final response = await HttpBase.post(Routa.registerUrl, model.toJson());
      if (response.statusCode == 200) {
        return ResponseRegisterModel.fromJson(jsonDecode(response.body));
      } else {
        throw CustomException(response.statusCode);
      }
    } catch (e, stackTrace) {
      log('RegisterService error: $e', stackTrace: stackTrace);
      throw CustomException(-1);
    }
  }
}
