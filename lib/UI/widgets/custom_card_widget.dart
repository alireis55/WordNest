import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:word_nest/core/models/response/response_random_word_model.dart';
import 'package:word_nest/ui/utils/app_colors.dart';
import 'package:word_nest/ui/utils/app_sizes.dart';

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
      this.titleColor = AppColors.red,
      this.contentColor = AppColors.cardContent,
      this.borderColor = AppColors.borderGrey,
      this.borderRadius = AppSizes.cardBorderRadius,
      this.fontSize = AppSizes.cardTextSize,
      this.borderWidth = AppSizes.cardBorderWidth,
      this.blurSigma = AppSizes.cardBlurSigma,
      this.backgroundColor,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          const BorderRadius.all(Radius.circular(AppSizes.cardBorderRadius)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
                Radius.circular(AppSizes.cardBorderRadius)),
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
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.cardPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                _buildTitle('Word'),
                _buildContent(randomWord?.word ?? ''),
                const Spacer(),
                _buildTitle('Pronunciation'),
                _buildContent(randomWord?.pronunciation ?? ''),
                const Spacer(),
                _buildTitle('Meaning'),
                _buildContent(randomWord?.meaning ?? ''),
                const Spacer(),
                _buildTitle('Level'),
                _buildLevel(randomWord?.level),
                const Spacer(),
                _buildTitle('Example'),
                _buildContent(randomWord?.example ?? ''),
                const Spacer(),
              ],
            ),
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
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize, color: contentColor),
    );
  }

  Widget _buildLevel(String? level) {
    Color color;
    switch (level) {
      case 'A1':
      case 'A2':
        color = AppColors.green;
        break;
      case 'B1':
      case 'B2':
        color = AppColors.orange;
        break;
      case 'C1':
      case 'C2':
        color = AppColors.errorRed;
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
