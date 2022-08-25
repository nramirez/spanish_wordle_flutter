import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:wordle/components/qwerty.dart';
import 'package:wordle/components/stats.dart';

import '../game_state.dart';
import 'board.dart';
import 'how_to.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Set<String> usedLetters;
  late Set<String> usedMatched;
  late Set<String> usedMatchedPosition;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var state = context.watch<GameState>();
    if (!state.isAnimating) {
      usedLetters = state.usedLetters.toSet();
      usedMatched = state.usedMatched.toSet();
      usedMatchedPosition = state.usedMatchedPosition.toSet();
      if (state.isFinished) {
        Future.delayed(Duration.zero, () async {
          showStats(context);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Flexible(
            child: GestureDetector(
              onTap: (() => showHowToPlayDialog(context)),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: Colors.black)),
                child: const Icon(
                  Icons.question_mark_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
                onTap: (() => showStats(context)),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    Icons.leaderboard_outlined,
                    color: Colors.black,
                    size: 33,
                  ),
                )),
          ),
          Flexible(
            child: GestureDetector(
                child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: 33,
                    ))),
          )
        ],
      ),
      body: const Board(),
      persistentFooterButtons: [
        Qwerty(
          usedLetters: usedLetters,
          usedMatched: usedMatched,
          usedMatchedPosition: usedMatchedPosition,
        ),
      ],
    );
  }
}
