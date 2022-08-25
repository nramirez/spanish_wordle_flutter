import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class Statistics {
  Statistics(this.lost, this.currentStreak, this.maxStreak, this.distribution);
  final int lost;
  final int currentStreak;
  final int maxStreak;
  final List<int> distribution;

  int winPercentage() {
    var total = played() == 0 ? 0 : wins() / played();
    return (total * 100).floor();
  }

  int played() {
    return lost + wins();
  }

  int wins() {
    return distribution.reduce((value, element) => element + value);
  }
}

class Database {
  late SharedPreferences prefs;

  Future<Statistics> getStatistics() async {
    prefs = await SharedPreferences.getInstance();

    return Statistics(_getInt("lost"), _getInt("currentStreak"),
        _getInt("maxStreak"), _getDistribution());
  }

  int _getInt(String key) {
    var v = prefs.getInt(key);
    return v ?? 0;
  }

  List<int> _getDistribution() {
    var dist = prefs.getString("distribution") ?? "0,0,0,0,0,0";
    return dist.split(',').map((e) => int.parse(e)).toList();
  }

  _registerLost() {
    var lost = _getInt("lost");
    prefs.setInt("lost", lost + 1);
    prefs.setInt("currentStreak", 0);
  }

  _registerWin(int tries) {
    var distribution = _getDistribution();
    distribution[tries - 1]++;
    prefs.setString("distribution", distribution.join(","));
    _incrementStreak();
  }

  _incrementStreak() {
    var currentStreak = _getInt("currentStreak");
    prefs.setInt("currentStreak", currentStreak + 1);
    var maxStreak = _getInt("maxStreak");
    prefs.setInt("maxStreak", max(maxStreak, currentStreak));
  }

  updateGame(int tries, bool won) async {
    // update before we save
    prefs = await SharedPreferences.getInstance();
    // if guess is more than 6 then they missed
    if (won) {
      _registerWin(tries);
    } else {
      _registerLost();
    }
  }
}
