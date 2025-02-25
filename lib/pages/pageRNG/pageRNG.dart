import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_dice/pages/pageRNG/components/incrementer.dart';

var randomizer = Random();

class PageRNG extends StatefulWidget {
  const PageRNG({super.key});

  @override
  State<PageRNG> createState() => _PageRNGState();
}

class _PageRNGState extends State<PageRNG> {
  ConfettiController _confettiController =
      ConfettiController(duration: Duration(seconds: 3));

  int max = 6;
  int min = 1;
  int number = 1;

  bool isShuffling = false;
  Future<void> shuffle() async {
    if (isShuffling) {
      return;
    }

    setState(() {
      isShuffling = true;
    });

    for (int i = 0; i < 30; i++) {
      await Future.delayed(Duration(milliseconds: (i * 5)));

      setState(() {
        number = randomizer.nextInt(max - min + 1) + min;
      });
    }
    setState(() {
      isShuffling = false;
    });
    _confettiController.play();
  }

  int setMax(int value) {
    if (value <= min) return max;
    max = value;
    return max;
  }

  int setMin(int value) {
    if (value >= max) return min;
    min = value;
    return min;
  }

  @override
  Widget build(BuildContext context) {
    Widget textNumber = AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      key: ValueKey<int>(number),
      child: Text(
        number.toString(),
        style: GoogleFonts.unbounded(
          fontSize: 72,
          color: const Color(0xFFedf2f4),
        ),
      ),
    );

    ElevatedButton buttonShuffle = ElevatedButton(
      onPressed: shuffle,
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (isShuffling) {
                return Colors.grey;
              }
              return Colors.white;
            },
          ),
          splashFactory: NoSplash.splashFactory),
      child: const Text("Shuffle"),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF2b2d42),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, -0.8),
              child: ConfettiWidget(
                numberOfParticles: 50,
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                gravity: 0.1,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Incrementer(
                      value: min,
                      title: "MIN",
                      parentCallBack: setMin,
                    ),
                    textNumber,
                    Incrementer(
                      value: max,
                      title: "MAX",
                      parentCallBack: setMax,
                    ),
                  ],
                ),
                buttonShuffle,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
