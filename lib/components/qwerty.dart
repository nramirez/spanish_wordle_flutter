import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game_state.dart';

class Qwerty extends StatelessWidget {
  const Qwerty(
      {Key? key,
      required this.usedLetters,
      required this.usedMatched,
      required this.usedMatchedPosition})
      : super(key: key);

  final Set<String> usedLetters;
  final Set<String> usedMatched;
  final Set<String> usedMatchedPosition;

  getColor(String t) {
    if (usedMatchedPosition.contains(t)) {
      return Colors.green;
    } else if (usedMatched.contains(t)) {
      return Colors.yellow;
    } else if (usedLetters.contains(t)) {
      return Colors.grey[600];
    }

    return Colors.grey[400];
  }

  Row _buildRow(int idx, updateCurrentGuess) {
    var keys = keyboardRows[idx];
    var k = keys
        .split('')
        .map((t) => Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: TextButton(
                    style: TextButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: getColor(t),
                    ),
                    onPressed: () => updateCurrentGuess(t),
                    child: Text(
                      t,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    )),
              ),
            ))
        .toList();

    if (idx == keyboardRows.length - 1) {
      k.insert(
        0,
        Flexible(
          flex: 2,
          child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor: Colors.grey[400],
              ),
              onPressed: () => updateCurrentGuess("enter"),
              child: const Text(
                "ENTER",
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
        ),
      );
      k.add(Flexible(
        flex: 2,
        child: TextButton(
            style: TextButton.styleFrom(
              alignment: Alignment.center,
              backgroundColor: Colors.grey[400],
            ),
            onPressed: () => updateCurrentGuess("delete"),
            child: const Icon(
              Icons.backspace_outlined,
              color: Colors.black,
            )),
      ));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: k,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
            child: _buildRow(0, context.watch<GameState>().updateCurrentGuess)),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildRow(1, context.watch<GameState>().updateCurrentGuess),
          ),
        ),
        Flexible(
            child: _buildRow(2, context.watch<GameState>().updateCurrentGuess))
      ],
    );
  }
}
