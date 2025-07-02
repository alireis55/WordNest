import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:word_nest/core/cubits/word_cubit.dart';
import 'package:word_nest/core/databases/database.dart';
import 'package:word_nest/ui/widgets/custom_card_widget.dart';
import 'package:word_nest/core/services/random_word_service.dart';
import 'package:word_nest/core/models/response/response_random_word_model.dart';
import 'package:logger/logger.dart';
import 'package:word_nest/ui/widgets/custom_refresh_indicator.dart';
import 'package:word_nest/ui/utils/app_sizes.dart';
import 'package:word_nest/ui/widgets/custom_card_swiper.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CardSwiperController cardSwiperController = CardSwiperController();
  int currentWordIndex = 0;

  @override
  void initState() {
    super.initState();
    if (context.read<WordCubit>().state.isEmpty) {
      getWords(context, true);
    }
    createDatabase();
  }

  Future<void> getWords(BuildContext content, bool showCircularBar) async {
    if (showCircularBar) {
      context.loaderOverlay.show();
    }
    for (int i = 0; i < 6; i++) {
      try {
        final randomWord = await RandomWordService.getRandomWord(context);
        if (mounted) {
          if (context
              .read<WordCubit>()
              .state
              .any((element) => element.word == randomWord.word?.word)) {
            debugPrint('word already exist: ${randomWord.word?.word}');
            i--;
          } else {
            debugPrint('added to list: ${randomWord.word?.word}');
            context.read<WordCubit>().addWord(randomWord);
          }
        }
      } catch (e, stackTrace) {
        Logger()
            .e('RandomWordService error: $e', error: e, stackTrace: stackTrace);
      }
      if (mounted) {
        debugPrint('state lenght: ${content.read<WordCubit>().state.length}');
      }
    }
    if (showCircularBar) {
      if (mounted) {
        context.loaderOverlay.hide();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomRefreshIndicator(
      onRefresh: () async {
        context.read<WordCubit>().clearWords();
        getWords(context, true);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: AppSizes.getMinConstraintsHeight(context),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      color: Colors.transparent,
                      height: 300,
                      width: 300,
                      child: SafeArea(
                        child: BlocBuilder<WordCubit, List<Word>>(
                          builder: (context, words) {
                            return CustomCardSwiper(
                              words: words,
                              controller: cardSwiperController,
                              numberOfCardsDisplayed: 3,
                              onSwipe: (previousIndex, currentIndex,
                                  direction) async {
                                if (currentIndex == words.length - 4) {
                                  await getWords(context, false);
                                }
                                setState(() {
                                  currentWordIndex = currentIndex ?? 0;
                                });
                                return true;
                              },
                              cardsCount: words.length,
                              currentWordIndex: currentWordIndex,
                              loading: context.loaderOverlay.visible,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      heroTag: "favorite",
                      focusElevation: 0,
                      highlightElevation: 0,
                      elevation: 7,
                      backgroundColor: const Color.fromARGB(255, 248, 245, 216),
                      onPressed: () async {
                        final currentWord =
                            context.read<WordCubit>().state[currentWordIndex];
                        await insertFavorite(
                            ResponseRandomWordModel(word: currentWord));
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 1),
                              backgroundColor:
                                  const Color.fromARGB(255, 36, 72, 101),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              content: Text(
                                  '${currentWord.word ?? "Word"} added to favorites'),
                            ),
                          );
                        });
                      },
                      child: const Icon(
                        size: 35,
                        Icons.star,
                        color: Color.fromARGB(255, 244, 221, 11),
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: "next",
                      highlightElevation: 0,
                      focusElevation: 0,
                      focusColor: Colors.transparent,
                      elevation: 7,
                      backgroundColor: const Color.fromARGB(255, 185, 219, 247),
                      onPressed: () {
                        cardSwiperController.swipe(CardSwiperDirection.right);
                        setState(() {
                          currentWordIndex++;
                        });
                      },
                      child: const Icon(
                        size: 35,
                        Icons.arrow_forward,
                        color: Color.fromARGB(255, 9, 136, 241),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
