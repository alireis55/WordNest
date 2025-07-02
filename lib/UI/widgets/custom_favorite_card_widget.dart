import 'dart:ui';
import 'package:flutter/material.dart';

class CustomFavoriteCardWidget extends StatelessWidget {
  final String word;
  final String level;
  final double fontSize;
  final Color titleColor;
  final Color levelColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double blurSigma;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const CustomFavoriteCardWidget({
    super.key,
    required this.word,
    required this.level,
    this.titleColor = const Color.fromARGB(255, 36, 72, 101),
    this.levelColor = const Color.fromARGB(255, 31, 31, 31),
    this.borderColor = const Color.fromARGB(255, 255, 247, 247),
    this.borderRadius = 20,
    this.fontSize = 20,
    this.borderWidth = 3,
    this.blurSigma = 20,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            border: Border.all(
              color: borderColor.withAlpha(75),
              width: borderWidth,
            ),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: borderColor.withAlpha(25),
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitle(word),
              const SizedBox(height: 8),
              _buildLevel(level),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        color: titleColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLevel(String? level) {
    Color color;
    switch (level) {
      case 'A1':
      case 'A2':
        color = Colors.green;
        break;
      case 'B1':
      case 'B2':
        color = Colors.orange;
        break;
      case 'C1':
      case 'C2':
        color = const Color.fromARGB(255, 102, 13, 6);
        break;
      default:
        color = levelColor;
    }
    return Text(
      level ?? '',
      style: TextStyle(
        fontWeight: FontWeight.w800,
        color: color,
        fontSize: fontSize - 2,
      ),
      textAlign: TextAlign.center,
    );
  }
}
