import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:word_nest/ui/utils/app_colors.dart';
import 'package:word_nest/ui/utils/app_sizes.dart';

class CustomGlobalLoaderOverlay extends StatelessWidget {
  final Widget child;
  const CustomGlobalLoaderOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayWidgetBuilder: (progress) {
        return const CircularProgressIndicator.adaptive(
          backgroundColor: AppColors.white,
        );
      },
      overlayColor: AppColors.loaderOverlay,
      overlayHeight: AppSizes.iconSizeLarge,
      overlayWidth: AppSizes.iconSizeLarge,
      child: child,
    );
  }
}
