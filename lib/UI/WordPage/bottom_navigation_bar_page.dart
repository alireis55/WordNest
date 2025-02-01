import 'package:flutter/material.dart';
import 'package:word_nest/UI/WordPage/favorite_page.dart';
import 'package:word_nest/UI/WordPage/word_page.dart';
import 'package:word_nest/UI/page_controller.dart';
import 'package:word_nest/UI/utils/token/token.dart';

class BottomNavigatorPage extends StatefulWidget {
  const BottomNavigatorPage({super.key});

  @override
  State<BottomNavigatorPage> createState() => _BottomNavigatorPageState();
}

class _BottomNavigatorPageState extends State<BottomNavigatorPage> {
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
              icon: const Icon(Icons.logout))
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
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
