import 'package:flutter/material.dart';

import '../models/letter.dart';
import 'animated_row.dart';

Widget exampleRow(String word, int position, LetterState state) {
  var idx = 0;
  List<Letter> letters = [];
  while (idx < word.length) {
    letters.add(Letter(word[idx], idx == position ? state : LetterState.none));
    idx++;
  }

  return Flexible(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: AnimatedRow(
        letters: letters,
        rowIdx: -1,
        rotateIdx: position + 1,
      ),
    ),
  );
}

showHowToPlayDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(""),
        const Flexible(child: Text("¿Como Jugar?")),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: const Icon(Icons.close)),
        )
      ],
    ),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text.rich(
          TextSpan(
              text: "Adivina la ",
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                    text: "PALABRA ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "en 6 intentos.\n"),
                TextSpan(
                    text:
                        "Cada intento debe ser una palabra de 5 letras. Click enter para enviar.\n"),
                TextSpan(
                    text:
                        "Despues de cada intento, el color de las letras cambia para mostar que tan cerca estuvo tu palabra.\n"),
              ]),
        ),
        const Flexible(child: Divider()),
        const Text("Examples",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        Flexible(child: exampleRow("MANGO", 0, LetterState.positionMatch)),
        const Text.rich(
          TextSpan(text: "La letra ", children: [
            TextSpan(text: "I ", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
              text: "esta en la palabra pero no en la posición correcta.",
            )
          ]),
        ),
        exampleRow("ROCAS", 1, LetterState.match),
        const Text.rich(
          TextSpan(text: "La letra ", children: [
            TextSpan(text: "O ", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
              text: "esta en la posición correcta.",
            )
          ]),
        ),
        exampleRow("BROMA", 3, LetterState.missed),
        const Text.rich(
          TextSpan(text: "La letra ", children: [
            TextSpan(text: "M ", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
              text: "no esta en ninguna posicion en la palabra.\n",
            )
          ]),
        ),
        const Divider(),
        const Flexible(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Una PALABRA nueva estará disponible cada día!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Divider(),
      ],
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: true,
    useSafeArea: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
