import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:word_nest/core/models/response/response_random_word_model.dart';

Widget containerCard(ResponseRandomWordModel? randomWord) {
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 247, 247).withAlpha(75),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(0, 255, 247, 247).withAlpha(25),
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
            Text(randomWord?.word?.word ?? ''),
            const Text(
              'Pronunciation',
              style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
            ),
            Text(randomWord?.word?.pronunciation ?? ''),
            const Text(
              'Meaning',
              style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
            ),
            Text(
              randomWord?.word?.meaning ?? '',
              textAlign: TextAlign.center,
            ),
            const Text(
              'Level',
              style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
            ),
            Text(randomWord?.word?.level ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: randomWord?.word?.level == 'beginner'
                        ? Colors.green
                        : randomWord?.word?.level == 'intermediate'
                            ? Colors.orange
                            : const Color.fromARGB(255, 102, 13, 6))),
            const Text(
              'Example',
              style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
            ),
            Text(
              randomWord?.word?.example ?? '',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ),
  );
}
