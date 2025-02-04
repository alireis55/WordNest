import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:word_nest/Cubit/word_cubit.dart';
import 'package:word_nest/UI/utils/DB/Database.dart';
import 'package:word_nest/UI/utils/api/models/random_word_model.dart';
import 'package:word_nest/UI/utils/api/routa.dart';
import 'package:word_nest/UI/utils/api/services/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    if (context.read<WordCubit>().state.isEmpty) {
      getWords();
    } else {
      setState(() {
        loading = false;
      });
    }
    createDatabase();
  }

  Future<void> getWords() async {
    for (int i = 0; i < 3; i++) {
      await HttpBase.get(Routa.randomeUrl).then((response) {
        final randomWord = RandomWordModel.fromJson(jsonDecode(response.body));
        if (mounted) {
          if (context
              .read<WordCubit>()
              .state
              .any((element) => element.word.word == randomWord.word.word)) {
            i--;
          } else {
            context.read<WordCubit>().addWord(randomWord);
          }
        }
      });
    }
    if (loading) {
      setState(() {
        loading = false;
      });
    }
  }

  bool loading = true;

  CardSwiperController cardSwiperController = CardSwiperController();

  int currentWordIndex = 0;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top -
                      56 -
                      MediaQuery.of(context).padding.bottom -
                      100,
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
                              child:
                                  BlocBuilder<WordCubit, List<RandomWordModel>>(
                                builder: (context, state) {
                                  return CardSwiper(
                                      onSwipe: (previousIndex, currentIndex,
                                          direction) {
                                        if (currentIndex == state.length - 2) {
                                          getWords();
                                        }
                                        setState(() {
                                          currentWordIndex = currentIndex!;
                                        });
                                        return true;
                                      },
                                      controller: cardSwiperController,
                                      backCardOffset: const Offset(30, 30),
                                      padding: const EdgeInsets.all(5),
                                      duration:
                                          const Duration(milliseconds: 350),
                                      cardBuilder: (context,
                                              index,
                                              percentThresholdX,
                                              percentThresholdY) =>
                                          containerCard(state[index]),
                                      cardsCount: state.length);
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
                            backgroundColor:
                                const Color.fromARGB(255, 248, 245, 216),
                            onPressed: () async {
                              final currentWord = context
                                  .read<WordCubit>()
                                  .state[currentWordIndex];
                              await insertFavorite(currentWord);
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
                                        '${currentWord.word.word} added to favorites'),
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
                            backgroundColor:
                                const Color.fromARGB(255, 185, 219, 247),
                            onPressed: () {
                              cardSwiperController
                                  .swipe(CardSwiperDirection.right);
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

Widget containerCard(RandomWordModel? randomWordModel) {
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 247, 247).withOpacity(0.3),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(0, 255, 247, 247).withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Word',
              style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
            ),
            Text(randomWordModel!.word.word),
            const Text(
              'Pronunciation',
              style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
            ),
            Text(randomWordModel.word.pronunciation),
            const Text(
              'Meaning',
              style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
            ),
            Text(
              randomWordModel.word.meaning,
              textAlign: TextAlign.center,
            ),
            const Text(
              'Level',
              style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
            ),
            Text(randomWordModel.word.level,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: randomWordModel.word.level == 'beginner'
                        ? Colors.green
                        : randomWordModel.word.level == 'intermediate'
                            ? Colors.orange
                            : const Color.fromARGB(255, 102, 13, 6))),
            const Text(
              'Example',
              style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
            ),
            Text(
              randomWordModel.word.example,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ),
  );
}
