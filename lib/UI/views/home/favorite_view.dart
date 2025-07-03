import 'package:flutter/material.dart';
import 'package:word_nest/ui/widgets/custom_favorite_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_nest/core/cubits/favorite_cubit.dart';
import 'package:word_nest/core/databases/local_storage.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';
import 'package:word_nest/ui/utils/app_colors.dart';
import 'package:word_nest/ui/utils/app_sizes.dart';

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

  Future<void> _removeItem(int id) async {
    context.read<FavoriteCubit>().deleteFavorite(id);
    await LocalStorage.deleteFavoriteById(id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, List<Map<String, dynamic>>>(
      builder: (context, favorites) {
        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final item = favorites[index];
            return DismissibleTile(
              key: ValueKey(item['id']),
              padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.dismissibleCardVerticalPadding,
                  horizontal: AppSizes.dismissibleCardHerizontalPadding),
              rtlBackground: Container(
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius:
                      BorderRadius.circular(AppSizes.dismissibleRadius),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(
                    right: AppSizes.dismissiblePaddingRight),
                child: const Icon(Icons.delete,
                    color: AppColors.red, size: AppSizes.dismissibleIconSize),
              ),
              onDismissed: (_) => _removeItem(item['id']),
              child: CustomFavoriteCardWidget(
                word: item['word'] ?? '',
                level: item['level'] ?? '',
              ),
            );
          },
        );
      },
    );
  }
}
