import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

class ClockProvider extends ChangeNotifier {
  String _whatsleft = '00:00:00';
  Duration passed = Duration(seconds: 0);
  Timer _timer;

  ClockProvider() {
    _startTimer();
  }

  String get whatsleft => _whatsleft;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      passed += Duration(seconds: 1);
      _whatsleft = format(passed);
      notifyListeners();
      // print("notified");
      // print(whatsleft);
    });
  }

  format(Duration d) =>
      (Duration(minutes: 5) - d).toString().split('.').first.padLeft(8, "0");
}
