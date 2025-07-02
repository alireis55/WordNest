import 'package:flutter/material.dart';
import 'package:word_nest/ui/utils/app_colors.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message,
      {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        backgroundColor: backgroundColor ?? AppColors.snackbarBlue,
      ),
    );
  }
}
