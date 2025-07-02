import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<List<Map<String, dynamic>>> {
  FavoriteCubit() : super([]);

  Future<void> loadFavorites(
      Future<List<Map<String, dynamic>>> Function() getFavorites) async {
    final favs = await getFavorites();
    emit(favs);
  }

  void setFavorites(List<Map<String, dynamic>> favs) {
    emit(favs);
  }

  void addFavorite(Map<String, dynamic> favorite) {
    final updated = List<Map<String, dynamic>>.from(state);
    updated.add(favorite);
    emit(updated);
  }

  void clearFavorites() {
    emit([]);
  }
}
