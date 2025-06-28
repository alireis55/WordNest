import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:word_nest/core/models/response/response_random_word_model.dart';

class WordCubit extends Cubit<List<ResponseRandomWordModel>> {
  WordCubit() : super([]);

  void addWord(ResponseRandomWordModel randomWord) {
    state.add(randomWord);
    emit(state);
  }

  void clearWords() {
    state.clear();
    emit(state);
  }

  void removeFisrtWord() {
    state.removeAt(0);
    emit(state);
  }
}
