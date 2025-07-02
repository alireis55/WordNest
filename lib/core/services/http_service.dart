import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:word_nest/core/services/token_service.dart';
import 'package:logger/logger.dart';

class HttpBase {
  static const _timeoutDuration = Duration(seconds: 15);

  static Future<http.Response> get(
    String url,
    BuildContext context,
  ) async {
    try {
      final token = await TokenService.getToken(context);
      final headers = _buildHeaders(token: token);
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(_timeoutDuration);
      return response;
    } on SocketException {
      Logger().e('HttpBase.get error: No Connection');
      rethrow;
    } on TimeoutException {
      Logger().e('HttpBase.get error: Timeout');
      rethrow;
    } catch (e, stackTrace) {
      Logger().e('HttpBase.get error: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  static Future<http.Response> post(
      String url, Map<String, dynamic> body) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: _buildHeaders(),
            body: jsonEncode(body),
          )
          .timeout(_timeoutDuration);
      debugPrint('Response: ${response.body}');
      return response;
    } on SocketException {
      Logger().e('HttpBase.post error: No Connection');
      rethrow;
    } on TimeoutException {
      Logger().e('HttpBase.post error: Timeout');
      rethrow;
    } catch (e, stackTrace) {
      Logger().e('HttpBase.post error: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  static Map<String, String> _buildHeaders({String? token}) {
    if (token != null && token.isNotEmpty) {
      return {
        'Content-Type': 'application/json',
        'Authorization': token,
      };
    }
    return {
      'Content-Type': 'application/json',
    };
  }
}
