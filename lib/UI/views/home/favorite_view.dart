import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:word_nest/core/databases/database.dart';

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
              return ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Card(
                    elevation: 0,
                    color: Colors.white..withAlpha(75),
                    child: ListTile(
                      title: Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                          '${favorites[index]['word']}'),
                      subtitle: Text(
                          style: TextStyle(
                              color: favorites[index]['level'] == 'beginner'
                                  ? Colors.green
                                  : favorites[index]['level'] == 'intermediate'
                                      ? Colors.orange
                                      : Colors.red),
                          textAlign: TextAlign.center,
                          '${favorites[index]['level']}'),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
