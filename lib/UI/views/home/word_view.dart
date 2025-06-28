import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:word_nest/core/cubits/word_cubit.dart';
import 'package:word_nest/core/databases/database.dart';
import 'package:word_nest/ui/widgets/card_widget.dart';
import 'package:word_nest/core/services/random_word_service.dart';
import 'package:word_nest/core/models/response/response_random_word_model.dart';
import 'package:word_nest/core/services/shared_preferences_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  CardSwiperController cardSwiperController = CardSwiperController();
  int currentWordIndex = 0;

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
    final token = await SharedPrefsHelper.getToken();
    for (int i = 0; i < 13; i++) {
      try {
        final randomWord = await RandomWordService.getRandomWord(token ?? "");
        if (mounted) {
          if (context
              .read<WordCubit>()
              .state
              .any((element) => element.word?.word == randomWord.word?.word)) {
            i--;
          } else {
            context.read<WordCubit>().addWord(randomWord);
          }
        }
      } catch (e) {
        // Hata yönetimi: İsterseniz burada kullanıcıya mesaj gösterebilirsiniz
        break;
      }
    }
    if (loading) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              setState(() {
                loading = true;
              });
              context.read<WordCubit>().clearWords();
              await getWords();
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
                              child: BlocBuilder<WordCubit,
                                  List<ResponseRandomWordModel>>(
                                builder: (context, state) {
                                  return CardSwiper(
                                      onSwipe: (previousIndex, currentIndex,
                                          direction) {
                                        if (currentIndex == state.length - 10) {
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
                                        '${currentWord.word?.word ?? "Word"} added to favorites'),
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
