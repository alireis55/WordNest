import 'package:flutter_bloc/flutter_bloc.dart';

class CacheCubit extends Cubit<String?> {
  CacheCubit() : super(null);

  void setToken(String? token) {
    emit(token);
  }

  void clearToken() {
    emit(null);
  }
}
