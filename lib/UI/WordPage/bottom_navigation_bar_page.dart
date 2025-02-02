import 'package:flutter/material.dart';
import 'package:word_nest/UI/WordPage/favorite_page.dart';
import 'package:word_nest/UI/WordPage/word_page.dart';
import 'package:word_nest/UI/page_controller.dart';
import 'package:word_nest/UI/utils/DB/Database.dart';
import 'package:word_nest/UI/utils/token/token.dart';

class BottomNavigatorPage extends StatefulWidget {
  const BottomNavigatorPage({super.key});

  @override
  State<BottomNavigatorPage> createState() => _BottomNavigatorPageState();
}

class _BottomNavigatorPageState extends State<BottomNavigatorPage> {
  Future<void> clearFavorites() async {
    await clearFavoriteTable();
    FavoritePage.loading.value = true;
  }

  List<Widget> pages = [
    const HomePage(),
    const FavoritePage(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Nest'),
        actions: [
          IconButton(
              onPressed: () async {
                await SharedPrefsHelper.deleteToken();
                // this is a workaround to avoid the error of calling a method
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PageControllerPage()));
                  },
                );
              },
              icon: const Icon(Icons.logout)),
          IconButton(
            onPressed: () async {
              await clearFavorites();
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined,
                  color: const Color.fromARGB(255, 22, 102, 168)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(currentIndex == 1 ? Icons.star : Icons.star_border,
                  color: const Color.fromARGB(255, 182, 167, 38)),
              label: 'Favorites',
            ),
          ],
          currentIndex: currentIndex,
          onTap: (value) => setState(() => currentIndex = value),
        ),
      ),
    );
  }
}
