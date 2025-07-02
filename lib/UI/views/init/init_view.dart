import 'package:flutter/material.dart';

class InitView extends StatelessWidget {
  const InitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/app_icon.png',
        ),
      ),
    );
  }
}
