import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:word_nest/Cubit/word_cubit.dart';
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
    }
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

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              context.read<WordCubit>().clearWords();
              //await getWords();
            },
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
                  //GlobalKey().currentContext!.size!.height ??,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            color: Colors.transparent,
                            height: 250,
                            width: 220,
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
                  ],
                ),
              ),
            ),
          );
  }
}

Widget containerCard(RandomWordModel? randomWordModel) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: Colors.black),
    ),
    child: Column(
      children: [
        Text(randomWordModel!.word.word),
        Text(randomWordModel.word.pronunciation),
        Text(randomWordModel.word.meaning),
        Text(randomWordModel.word.level),
        Text(randomWordModel.word.example)
      ],
    ),
  );
}
