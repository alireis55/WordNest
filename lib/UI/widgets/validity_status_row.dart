import 'package:flutter/material.dart';

class ValidityStatusRow extends StatelessWidget {
  final bool isValid;
  final String text;

  const ValidityStatusRow({
    super.key,
    required this.isValid,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 15,
        ),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
