import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:provider/provider.dart';

import '../game_state.dart';
import '../models/letter.dart';

import 'animated_cell.dart';

class CustomShakeAnimated implements ShakeConstant {
  @override
  Duration get duration => const Duration(milliseconds: 200);

  @override

  /// range: 0 - 100 && incremental, last value must equal 100.
  /// when only have oneelement,represents the same interval
  List<int> get interval => [50];

  @override

  /// range: 0 - 1.0, []:1.0 = [1.0]
  List<double> get opacity => const [];

  @override

  /// eg: 45deg = pi / 4, []:0 = [45]: rotate 45deg
  List<double> get rotate => const [];

  @override
  // Offset(double dx, double dy)
  List<Offset> get translate => const [
        Offset(-3, 0),
        Offset(0, 0),
        Offset(-3, 0),
      ];
}

class AnimatedRow extends StatelessWidget {
  final int rowIdx;
  final MainAxisAlignment mainAxisAlignment;
  final int rotateIdx;

  final List<Letter> letters;
  const AnimatedRow({
    Key? key,
    required this.letters,
    required this.rowIdx,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.rotateIdx = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var st = context.watch<GameState>();
    var isCurrent = rowIdx == st.guesses.length;
    var isPrev = rowIdx == st.guesses.length - 1;
    var shouldRotate = false;
    var shouldShake = false;

    if (isCurrent && st.events.contains("SHAKE-CURRENT")) {
      shouldShake = true;
      st.clearEvent("SHAKE-CURRENT");
    }

    if (isPrev && st.events.contains("ROTATE-PREV")) {
      shouldRotate = true;
      st.clearEvent("ROTATE-PREV");
    }

    int idx = 0;
    var constant = CustomShakeAnimated();
    return ShakeWidget(
        duration: const Duration(milliseconds: 130),
        shakeConstant: constant,
        autoPlay: shouldShake,
        enableWebMouseHover: false,
        child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: letters.map((l) {
              idx++;
              return Flexible(
                child: AnimatedCell(
                    l: l,
                    delay: idx,
                    rotate: shouldRotate,
                    immediateRotate: rotateIdx == idx),
              );
            }).toList()));
  }
}
