import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:word_nest/core/database/database.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  static ValueNotifier<bool> loading = ValueNotifier<bool>(true);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Future<void> showFavorites() async {
    final List favoritess = await getFavorites();
    setState(() {
      favorites = favoritess;
    });
    await Future.delayed(Duration.zero);
    if (mounted) {
      setState(() {
        FavoritePage.loading.value = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    showFavorites();
    FavoritePage.loading.addListener(() async {
      if (FavoritePage.loading.value && mounted) {
        setState(() {
          FavoritePage.loading.value = true;
        });
        await showFavorites();
      }
    });
  }

  List favorites = [];

  @override
  Widget build(BuildContext context) {
    return FavoritePage.loading.value
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
                    color: Colors.white.withOpacity(0.3),
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
