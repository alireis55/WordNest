import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_nest/core/services/shared_preferences_service.dart';

class AuthorizationCubit extends Cubit<bool> {
  AuthorizationCubit() : super(false);

  Future<void> checkAuthorization() async {
    final token = await SharedPrefsHelper.getToken();
    emit(token != null && token.isNotEmpty);
  }

  Future<void> login(String token) async {
    await SharedPrefsHelper.setToken(token);
    emit(true);
  }

  Future<void> logout() async {
    await SharedPrefsHelper.deleteToken();
    emit(false);
  }
}
