import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_nest/core/cubits/cache_cubit.dart';
import 'package:word_nest/core/services/shared_preferences_service.dart';

class TokenService {
  static Future<String> getToken(BuildContext context) async {
    final cacheToken = context.read<CacheCubit>().state;
    final savedToken = await SharedPrefsHelper.getToken();
    if (savedToken != null && savedToken.isNotEmpty) {
      //saved tokne has returned
      return savedToken;
    } else {
      //cache token has returned
      return cacheToken as String;
    }
  }
}
