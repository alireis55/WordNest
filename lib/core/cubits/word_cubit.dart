import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:word_nest/core/models/response/response_random_word_model.dart';

class WordCubit extends Cubit<List<Word>> {
  WordCubit() : super([]);

  void addWord(ResponseRandomWordModel randomWord) {
    if (randomWord.word != null) {
      emit([...state, randomWord.word!]);
    }
  }

  void clearWords() {
    state.clear();
    emit([]);
  }
}
