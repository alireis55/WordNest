import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:word_nest/core/databases/database.dart';
import 'package:word_nest/ui/widgets/custom_favorite_card_widget.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  static ValueNotifier<bool> loading = ValueNotifier<bool>(true);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  Future<void> showFavorites() async {
    final List favoritess = await getFavorites();
    setState(() {
      favorites = favoritess;
    });
    await Future.delayed(Duration.zero);
    if (mounted) {
      setState(() {
        FavoriteView.loading.value = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    showFavorites();
    FavoriteView.loading.addListener(() async {
      if (FavoriteView.loading.value && mounted) {
        setState(() {
          FavoriteView.loading.value = true;
        });
        await showFavorites();
      }
    });
  }

  List favorites = [];

  @override
  Widget build(BuildContext context) {
    return FavoriteView.loading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
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
  }
}
