import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? top;
  final double? left;

  const CustomBackButton({
    super.key,
    this.onPressed,
    this.top,
    this.left,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top ?? MediaQuery.of(context).padding.top,
      left: left ?? 20,
      child: IconButton(
        onPressed: onPressed ??
            () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
