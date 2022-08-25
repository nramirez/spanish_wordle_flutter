import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wordle/game_state.dart';

import 'components/home.dart';

Future main() async {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider<GameState>(create: (_) => GameState())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gameState = context.read<GameState>();

    // initialize the array
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plbreo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Focus(
        autofocus: true,
        child: const MyHomePage(title: 'Plbreo'),
        onKey: (FocusNode node, RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.character?.isNotEmpty == true) {
              gameState.updateCurrentGuess(event.character.toString());
            }
            if (event.logicalKey == LogicalKeyboardKey.enter) {
              gameState.updateCurrentGuess("enter");
            }
            if (event.logicalKey == LogicalKeyboardKey.backspace) {
              gameState.updateCurrentGuess("delete");
            }
          }
          return KeyEventResult.handled;
        },
      ),
    );
  }
}
