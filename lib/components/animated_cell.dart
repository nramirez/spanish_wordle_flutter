import 'package:flutter/material.dart';

import '../models/letter.dart';
import 'package:flip_card/flip_card.dart';

class AnimatedCell extends StatefulWidget {
  const AnimatedCell(
      {Key? key,
      required this.l,
      required this.rotate,
      required this.delay,
      required this.immediateRotate})
      : super(key: key);
  final Letter l;

  final bool rotate;

  final int delay;

  final bool immediateRotate;

  @override
  State<AnimatedCell> createState() => _AnimatedCellState();
}

class _AnimatedCellState extends State<AnimatedCell> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    var color = widget.l.getColor();
    var bsize = 50.0;
    Color bgcolor = Colors.grey;
    var fcolor = Colors.black;
    if (widget.l.state != LetterState.none) {
      bgcolor = color;
      fcolor = Colors.white;
    }

    var front = Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(
              color: widget.l.text.isNotEmpty ? Colors.black54 : Colors.black12,
              width: 2),
          color: Colors.transparent),
      width: bsize,
      height: bsize,
      child: Text(
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black),
          widget.l.text.toUpperCase()),
    );

    var back = Container(
      decoration: BoxDecoration(
          border: Border.all(color: bgcolor, width: 2), color: bgcolor),
      margin: const EdgeInsets.all(2),
      width: bsize,
      height: bsize,
      child: Text(
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 40, color: fcolor),
          widget.l.text.toUpperCase()),
    );

    if (widget.immediateRotate) {
      Future.delayed(const Duration(milliseconds: 300), () async {
        cardKey.currentState!.toggleCard();
      });
    } else if (widget.rotate) {
      Future.delayed(Duration(milliseconds: widget.delay * 300), () async {
        cardKey.currentState!.toggleCard();
      });
    }

    return FlipCard(
        key: cardKey,
        direction: FlipDirection.VERTICAL,
        flipOnTouch: false,
        front: front,
        back: back);
  }
}
