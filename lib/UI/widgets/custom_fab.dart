import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const CustomFAB({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.size = 35,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      elevation: 7,
      focusElevation: 0,
      highlightElevation: 0,
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      child: Icon(
        icon,
        size: size,
        color: iconColor,
      ),
    );
  }
}
