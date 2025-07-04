import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:word_nest/core/cubits/word_cubit.dart';
import 'package:word_nest/ui/views/home/favorite_View.dart';
import 'package:word_nest/ui/views/home/home_view.dart';
import 'package:word_nest/ui/views/root/root_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_nest/core/cubits/authorization_cubit.dart';
import 'package:word_nest/UI/utils/navigation_helper.dart';
import 'package:word_nest/ui/widgets/navigation_background.dart';
import 'package:word_nest/core/cubits/favorite_cubit.dart';
import 'package:word_nest/core/databases/local_storage.dart';
import 'package:word_nest/ui/utils/app_colors.dart';
import 'package:word_nest/ui/utils/app_sizes.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final List<Widget> _pages = const [HomeView(), FavoriteView()];
  int _currentIndex = 0;

  Future<void> _clearFavorites() async {
    await LocalStorage.clearFavoriteTable();
    if (mounted) {
      context.read<FavoriteCubit>().clearFavorites();
    }
  }

  void _logout() async {
    context.loaderOverlay.progress(true);
    await context.read<AuthorizationCubit>().logout();
    await LocalStorage.clearFavoriteTable();
    if (mounted) {
      context.read<FavoriteCubit>().clearFavorites();
      context.read<WordCubit>().clearWords();
    }
    if (mounted) {
      NavigationHelper.pushReplacement(context, const RootView());
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white.withAlpha(125),
      elevation: 0,
      title: const Text(
        'Word Nest',
        style: TextStyle(color: AppColors.black),
      ),
      actions: [
        _currentIndex == 0
            ? IconButton(
                onPressed: _logout,
                icon: const Icon(
                  Icons.logout,
                  color: AppColors.black,
                ),
              )
            : IconButton(
                onPressed: _clearFavorites,
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.black,
                ),
              ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: AppColors.transparent,
      ),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: AppColors.white.withAlpha(125),
        selectedItemColor:
            _currentIndex == 0 ? AppColors.darkBlue : AppColors.gold,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              size: AppSizes.iconSizeMedium,
              _currentIndex == 0 ? Icons.home : Icons.home_outlined,
              color: AppColors.darkBlue,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              size: AppSizes.iconSizeMedium,
              _currentIndex == 1 ? Icons.star : Icons.star_border,
              color: AppColors.gold,
            ),
            label: 'Favorites',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (value) => setState(() => _currentIndex = value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: AppColors.transparent,
      appBar: _buildAppBar(),
      body: NavigationBackground(
        child: SafeArea(child: _pages[_currentIndex]),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
