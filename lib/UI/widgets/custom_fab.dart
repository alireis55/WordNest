import 'package:flutter/material.dart';
import 'package:word_nest/ui/utils/app_sizes.dart';

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
    this.size = AppSizes.fabIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      elevation: AppSizes.fabElevation,
      focusElevation: AppSizes.fabFocusElevation,
      highlightElevation: AppSizes.fabHighLightElevation,
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
