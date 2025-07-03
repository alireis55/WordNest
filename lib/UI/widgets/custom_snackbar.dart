import 'package:flutter/material.dart';
import 'package:word_nest/ui/utils/app_colors.dart';
import 'package:word_nest/ui/utils/app_sizes.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message,
      {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.snackBarRadius),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor ?? AppColors.snackbarBlue,
      ),
    );
  }
}
