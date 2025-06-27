import 'package:word_nest/core/services/http_service.dart';
import 'package:word_nest/core/services/routes/route.dart';
import 'package:word_nest/core/models/response/response_random_word_model.dart';
import 'dart:convert';

class RandomWordService {
  static Future<ResponseRandomWordModel> getRandomWord(String token) async {
    try {
      final response = await HttpBase.getWithToken(Routa.randomeUrl, token);
      if (response.statusCode == 200) {
        return ResponseRandomWordModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
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
