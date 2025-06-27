import 'package:flutter/material.dart';
import 'package:word_nest/UI/view/home/favorite_View.dart';
import 'package:word_nest/UI/view/home/word_view.dart';
import 'package:word_nest/UI/view/root/root_view.dart';
import 'package:word_nest/core/database/database.dart';
import 'package:word_nest/core/token/token.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  Future<void> clearFavorites() async {
    await clearFavoriteTable();
    FavoriteView.loading.value = true;
  }

  List<Widget> pages = [
    const HomePage(),
    const FavoriteView(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white..withAlpha(125),
        elevation: 0,
        title: const Text('Word Nest'),
        actions: [
          currentIndex == 0
              ? IconButton(
                  onPressed: () async {
                    await SharedPrefsHelper.deleteToken();
                    // this is a workaround to avoid the error of calling a method
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RootView()));
                      },
                    );
                  },
                  icon: const Icon(Icons.logout))
              : IconButton(
                  onPressed: () {
                    clearFavorites();
                  },
                  icon: const Icon(Icons.delete),
                )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/core/assets/background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(child: pages[currentIndex]),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white..withAlpha(125),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                  size: 30,
                  currentIndex == 0 ? Icons.home : Icons.home_outlined,
                  color: const Color.fromARGB(255, 22, 102, 168)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  size: 30,
                  currentIndex == 1 ? Icons.star : Icons.star_border,
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
