import 'package:flutter/material.dart';

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
        backgroundColor:
            backgroundColor ?? const Color.fromARGB(255, 36, 72, 101),
      ),
    );
  }
}
