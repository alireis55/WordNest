import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final TextStyle? textStyle;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textStyle,
    this.borderRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      height: 54,
      child: Container(
        decoration: BoxDecoration(
          gradient: color == null
              ? const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 122, 199, 245),
                    Color.fromARGB(255, 50, 199, 245),
                    Color.fromARGB(255, 122, 199, 245)
                  ],
                )
              : null,
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            //overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
          child: Text(
            text,
            style: textStyle ?? const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
