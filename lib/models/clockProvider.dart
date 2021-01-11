import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

class ClockProvider extends ChangeNotifier {
  int _timeLimit;
  int _timeFinishes;
  bool _timeAlmostOver;
  bool _timeOver;
  String _whatsleft;
  Duration passed = Duration(seconds: 0);
  bool _idle = true;
  Timer _timer;

  ClockProvider() {
    if (_idle == true) {
      print("Idle : " + idle.toString());
      _startTimer();
      _idle = false;
      _timeAlmostOver = false;
      _timeOver = false;
      _timeLimit = 5;
      _whatsleft = '00:0' + _timeLimit.toString() + ':00';
      _timeFinishes = 1;
    }
  }

  String get whatsleft => _whatsleft;

  bool get idle => _idle;

  bool get timeAlmostOver => _timeAlmostOver;

  bool get timeOver => _timeOver;

  int get timeLimit => _timeLimit;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      passed += Duration(seconds: 1);
      _whatsleft = format(passed);
      if (passed.inSeconds.abs() > timeLimit - _timeFinishes) {
        _timeAlmostOver = true;
      }
      if (passed.inSeconds.abs() > timeLimit) {
        _timeOver = true;
      }
      _idle = false;
      notifyListeners();
    });
  }

  void start() {
    _startTimer();
  }

  void stop() {
    _timer.cancel();
    passed = Duration(seconds: 0);
    _whatsleft = '00:05:00';
    _idle = true;
    _timeAlmostOver = false;
  }

  format(Duration d) =>
      (Duration(minutes: 5) - d).toString().split('.').first.padLeft(8, "0");
}
