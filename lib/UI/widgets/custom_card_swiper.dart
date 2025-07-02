import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:word_nest/core/models/response/response_random_word_model.dart';
import 'package:word_nest/ui/widgets/custom_card_widget.dart';

class CustomCardSwiper extends StatelessWidget {
  final List<Word> words;
  final CardSwiperController controller;
  final int numberOfCardsDisplayed;
  final CardSwiperOnSwipe? onSwipe;
  final int cardsCount;
  final int currentWordIndex;
  final bool loading;

  const CustomCardSwiper({
    super.key,
    required this.words,
    required this.controller,
    required this.numberOfCardsDisplayed,
    required this.onSwipe,
    required this.cardsCount,
    required this.currentWordIndex,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return CardSwiper(
        onSwipe: onSwipe,
        controller: controller,
        backCardOffset: const Offset(30, 30),
        padding: const EdgeInsets.all(5),
        duration: const Duration(milliseconds: 350),
        numberOfCardsDisplayed: 3,
        cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
            CustomCardWidget(
                randomWord: Word(
                    word: '---',
                    example: '---',
                    id: '---',
                    level: '---',
                    meaning: '---',
                    pronunciation: '---')),
        cardsCount: 3,
      );
    }
    return CardSwiper(
      onSwipe: onSwipe,
      controller: controller,
      backCardOffset: const Offset(30, 30),
      padding: const EdgeInsets.all(5),
      duration: const Duration(milliseconds: 350),
      numberOfCardsDisplayed: numberOfCardsDisplayed,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
          CustomCardWidget(randomWord: words[index]),
      cardsCount: cardsCount,
    );
  }
}
