import 'dart:developer';

import 'package:word_nest/core/services/http_service.dart';
import 'package:word_nest/core/services/routes/route.dart';
import 'package:word_nest/core/models/response/response_random_word_model.dart';
import 'dart:convert';
import 'package:word_nest/core/errors/custom_exception.dart';

class RandomWordService {
  static Future<ResponseRandomWordModel> getRandomWord(String token) async {
    try {
      final response = await HttpBase.get(Routa.randomeUrl);

      if (response.statusCode == 200) {
        return ResponseRandomWordModel.fromJson(jsonDecode(response.body));
      }

      throw CustomException(response.statusCode);
    } on CustomException catch (e, stackTrace) {
      log('RandomWordService error: $e', stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      log('RandomWordService error: $e', stackTrace: stackTrace);
      throw CustomException(-1);
    }
  }
}
