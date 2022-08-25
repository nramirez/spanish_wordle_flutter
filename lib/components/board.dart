import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game_state.dart';
import '../models/letter.dart';
import 'animated_row.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gameState = context.watch<GameState>();
    var guesses = gameState.guesses;
    var currentGuess = gameState.currentGuess;
    var rowIdx = 0;
    var b = <Widget>[];

    while (rowIdx < GameState.tries) {
      var guess = "";
      if (rowIdx <= guesses.length) {
        guess = rowIdx == guesses.length ? currentGuess : guesses[rowIdx];
      }
      var lidx = -1;
      var letters = gameState.validateWord(guess).map((s) {
        lidx++;
        var txt = lidx >= guess.length ? "" : guess[lidx];
        var st = rowIdx == guesses.length ? LetterState.none : s;
        return Letter(txt, st);
      }).toList();
      b.add(Flexible(
        child: AnimatedRow(
            mainAxisAlignment: MainAxisAlignment.center,
            letters: letters,
            rowIdx: rowIdx),
      ));
      rowIdx++;
    }

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: b);
  }
}
