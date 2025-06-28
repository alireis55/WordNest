import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CustomGlobalLoaderOverlay extends StatelessWidget {
  final Widget child;
  const CustomGlobalLoaderOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayWidgetBuilder: (progress) {
        return const CircularProgressIndicator.adaptive(
          backgroundColor: Colors.white,
        );
      },
      overlayColor: Colors.black.withAlpha(125),
      overlayHeight: 50,
      overlayWidth: 50,
      child: child,
    );
  }
}
