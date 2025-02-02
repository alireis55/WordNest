import 'package:flutter/material.dart';
import 'package:word_nest/UI/utils/DB/Database.dart';

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
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      FavoritePage.loading.value = false;
    });
  }

  @override
  void initState() {
    super.initState();
    showFavorites();
    FavoritePage.loading.addListener(() async {
      if (FavoritePage.loading.value) {
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
        : ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Word ${favorites[index]['word']}'),
              );
            },
          );
  }
}
