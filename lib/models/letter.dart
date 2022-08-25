import 'package:flutter/material.dart';

enum LetterState { none, match, positionMatch, missed }

class Letter {
  final String text;
  final LetterState state;

  Color getColor() {
    if (state == LetterState.positionMatch) {
      return const Color.fromARGB(255, 81, 140, 83);
    }

    if (state == LetterState.match) {
      return const Color.fromARGB(255, 197, 178, 7);
    }
    if (state == LetterState.missed) {
      return Colors.grey;
    }

    return Colors.transparent;
  }

  Letter(this.text, this.state);
}
