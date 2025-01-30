import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:word_nest/Cubit/word_cubit.dart';
import 'package:word_nest/UI/utils/api/models/random_word_model.dart';
import 'package:word_nest/UI/utils/api/routa.dart';
import 'package:word_nest/UI/utils/api/services/http.dart';

class WordPage extends StatefulWidget {
  const WordPage({super.key});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  @override
  void initState() {
    super.initState();
    getWords();
  }

  Future<void> getWords() async {
    for (int i = 0; i < 3; i++) {
      await HttpBase.get(Routa.randomeUrl).then((response) {
        final randomWord = RandomWordModel.fromJson(jsonDecode(response.body));
        if (mounted) {
          context.read<WordCubit>().addWord(randomWord);
        }
      });
    }
    setState(() {
      loading = false;
    });
  }

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Word Nest'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
          ],
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  context.read<WordCubit>().clearWords();
                  await getWords();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height -
                          MediaQuery.of(context).padding.top,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 250,
                              width: 220,
                              child: SafeArea(
                                child: Flexible(
                                  child: BlocBuilder<WordCubit, List>(
                                    builder: (context, state) {
                                      return CardSwiper(
                                          backCardOffset: const Offset(30, 30),
                                          padding: const EdgeInsets.all(5),
                                          duration:
                                              const Duration(milliseconds: 350),
                                          cardBuilder: (context,
                                                  index,
                                                  percentThresholdX,
                                                  percentThresholdY) =>
                                              containerCard(
                                                  Colors.grey, state[index]),
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
              ));
  }
}

Widget containerCard(Color? color, RandomWordModel? randomWordModel) {
  return Container(
    decoration: BoxDecoration(
      color: color,
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
