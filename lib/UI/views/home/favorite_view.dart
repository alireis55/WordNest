import 'package:flutter/material.dart';
import 'package:word_nest/ui/widgets/custom_favorite_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_nest/core/cubits/favorite_cubit.dart';
import 'package:word_nest/core/databases/local_storage.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().loadFavorites(LocalStorage.getFavorites);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, List<Map<String, dynamic>>>(
      builder: (context, favorites) {
        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: CustomFavoriteCardWidget(
                word: favorites[index]['word'] ?? '',
                level: favorites[index]['level'] ?? '',
              ),
            );
          },
        );
      },
    );
  }
}
