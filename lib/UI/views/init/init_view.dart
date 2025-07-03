import 'package:flutter/material.dart';
import 'package:word_nest/ui/utils/app_colors.dart';
import 'package:word_nest/ui/utils/app_sizes.dart';

class InitView extends StatelessWidget {
  const InitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(
          'assets/app_icon.png',
          width: AppSizes.logoSize,
          height: AppSizes.logoSize,
        ),
      ),
    );
  }
}
