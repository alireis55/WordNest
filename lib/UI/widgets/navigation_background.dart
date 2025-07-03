import 'package:flutter/material.dart';

class NavigationBackground extends StatelessWidget {
  final Widget child;
  const NavigationBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/navigation_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
