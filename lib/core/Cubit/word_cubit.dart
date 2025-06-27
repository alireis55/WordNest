import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:word_nest/core/models/random_word_model.dart';

class WordCubit extends Cubit<List<RandomWordModel>> {
  WordCubit() : super([]);

  void addWord(RandomWordModel randomWordModel) {
    state.add(randomWordModel);
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
