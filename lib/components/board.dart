import 'package:flutter/material.dart';

import '../game_state.dart';

class Board extends StatelessWidget {
  const Board({Key? key, required this.state}) : super(key: key);
  final GameState state;

  getRow() {
    var idx = 0;
    List<Widget> children = [];

    while (idx < state.word.length) {
      children.add(Container(
        margin: const EdgeInsets.all(2),
        decoration:
            BoxDecoration(border: Border.all(width: 2, color: Colors.grey)),
        width: 50,
        height: 50,
        child: const Text(
          "T",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          textAlign: TextAlign.center,
        ),
      ));
      idx++;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Column getBoard() {
    var idx = 0;

    List<Widget> children = [];

    while (idx < state.tries) {
      children.add(getRow());
      idx++;
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.center, children: children);
  }

  @override
  Widget build(BuildContext context) {
    return getBoard();
  }
}
