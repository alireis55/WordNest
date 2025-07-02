import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:word_nest/core/models/response/response_random_word_model.dart';

class CustomCardWidget extends StatelessWidget {
  final Word? randomWord;
  final double fontSize;
  final Color titleColor;
  final Color contentColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double blurSigma;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const CustomCardWidget(
      {super.key,
      required this.randomWord,
      this.titleColor = Colors.red,
      this.contentColor = const Color.fromARGB(255, 31, 31, 31),
      this.borderColor = const Color.fromARGB(255, 255, 247, 247),
      this.borderRadius = 20,
      this.fontSize = 18,
      this.borderWidth = 3,
      this.blurSigma = 50,
      this.backgroundColor,
      this.padding});

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitle('Word'),
              _buildContent(randomWord?.word ?? ''),
              _buildTitle('Pronunciation'),
              _buildContent(randomWord?.pronunciation ?? ''),
              _buildTitle('Meaning'),
              _buildContent(randomWord?.meaning ?? ''),
              _buildTitle('Level'),
              _buildLevel(randomWord?.level),
              _buildTitle('Example'),
              _buildContent(randomWord?.example ?? ''),
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
          fontSize: fontSize, fontWeight: FontWeight.w800, color: titleColor),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildContent(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize, color: contentColor),
      ),
    );
  }

  Widget _buildLevel(String? level) {
    Color color;
    switch (level) {
      case 'A1' || 'A2':
        color = Colors.green;
        break;
      case 'B1' || 'B2':
        color = Colors.orange;
        break;
      case 'C1' || 'C2':
        color = const Color.fromARGB(255, 102, 13, 6);
        break;
      default:
        color = contentColor;
    }
    return Text(
      level ?? '',
      style: TextStyle(
        fontWeight: FontWeight.w800,
        color: color,
        fontSize: fontSize,
      ),
      textAlign: TextAlign.center,
    );
  }
}
