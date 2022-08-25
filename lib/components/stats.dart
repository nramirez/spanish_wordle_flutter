import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../db.dart';

Widget getGuessStat(int row, int val, int max) {
  var perc = val / max;
  return Flexible(
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Row(children: [
        Text(
          row.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: LinearPercentIndicator(
            trailing: Text(
              val.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            percent: perc,
            lineHeight: 20,
            progressColor: Colors.black54,
            backgroundColor: Colors.transparent,
          ),
        ),
      ]),
    ),
  );
}

List<Widget> guessDistribution(Statistics stats) {
  if (stats.played() == 0) {
    return const [Text("No Data")];
  }
  var maxCount =
      stats.distribution.reduce((value, element) => max(value, element));
  var idx = 1;

  return stats.distribution
      .map((e) => getGuessStat(idx++, e, maxCount))
      .toList();
}

getStatsBody(Statistics stats) {
  return Flexible(
    child: Column(
      children: [
        const Text(
          "STATISTICS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    stats.played().toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    "Partidas",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    stats.winPercentage().toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    "Ganadas %",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    stats.currentStreak.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    "Racha",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    stats.maxStreak.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    "Racha Max",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Text(
          "GUESS DISTRIBUTION",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ...guessDistribution(stats)
      ],
    ),
  );
}

showStats(BuildContext context) {
  AlertDialog alert = AlertDialog(
      title: Align(
        alignment: Alignment.topRight,
        child: IconButton(
            onPressed: () => {Navigator.of(context).pop()},
            icon: const Icon(Icons.close)),
      ),
      content: FutureBuilder(
          future: Database().getStatistics(),
          builder: ((context, snapshot) {
            if (snapshot.data == null) {
              return const CircularProgressIndicator.adaptive();
            }

            var stats = snapshot.data as Statistics;
            return getStatsBody(stats);
          })));

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
