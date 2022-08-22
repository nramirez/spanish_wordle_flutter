import 'package:flutter/material.dart';

const List<String> boardkeys = ["qwertyuiop", "asdfghjkl", "zxcvbnm"];

class Qwerty extends StatelessWidget {
  const Qwerty({Key? key}) : super(key: key);

  Widget buildRow(int idx) {
    List<Widget> children = boardkeys[idx]
        .split('')
        .map((t) => Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: TextButton(
                    onPressed: () => {},
                    style: TextButton.styleFrom(
                        alignment: Alignment.center,
                        backgroundColor: Colors.grey),
                    child: Text(
                      t,
                      style: const TextStyle(color: Colors.black),
                    )),
              ),
            ))
        .toList();

    if (idx == boardkeys.length - 1) {
      children.insert(
          0,
          Flexible(
              flex: 2,
              child: TextButton(
                onPressed: () => {},
                style: TextButton.styleFrom(
                    alignment: Alignment.center, backgroundColor: Colors.grey),
                child: const Text(
                  "ENTER",
                  style: TextStyle(color: Colors.black),
                ),
              )));
      children.add(Flexible(
          child: TextButton(
              onPressed: () => {},
              style: TextButton.styleFrom(
                  alignment: Alignment.center, backgroundColor: Colors.grey),
              child: const Icon(
                Icons.backspace_outlined,
                color: Colors.black,
              ))));
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: buildRow(0)),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: buildRow(1),
          )),
          Flexible(child: buildRow(2))
        ],
      ),
    );
  }
}
