import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

class ClockProvider {
  static int _timeLimit;
  static int _timeFinishes;
  static bool _timeAlmostOver;
  static bool _timeOver;
  static String _whatsleft;
  static Duration passed = Duration(seconds: 0);
  static bool _idle = true;
  static Timer _timer;

  ClockProvider() {
    if (_idle == true) {
      print("Idle : " + idle.toString());
      _startTimer();
      _idle = false;
      _timeAlmostOver = false;
      _timeOver = false;
      _timeLimit = 2;
      _whatsleft = '00:0' + _timeLimit.toString() + ':00';
      _timeFinishes = 1;
    }
  }

  static String get whatsleft => _whatsleft;

  static bool get idle => _idle;

  static bool get timeAlmostOver => _timeAlmostOver;

  static bool get timeOver => _timeOver;

  static int get timeLimit => _timeLimit;

  static int get timeFinishes => _timeFinishes;

  static void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      passed += Duration(seconds: 1);
      _whatsleft = format(passed);
      if (passed.inMinutes.abs() > timeLimit - timeFinishes - 1) {
        _timeAlmostOver = true;
      }
      // if (passed.inMinutes.abs() > timeLimit - 1) {
      if (passed.inSeconds.abs() > 5) {
        _timeOver = true;
      }
      // print(passed.inSeconds.toString());
      _idle = false;
    });
  }

  static void start() {
    _startTimer();
  }

  static void stop() {
    _timer.cancel();
    passed = Duration(seconds: 0);
    _whatsleft = '00:05:00';
    _idle = true;
    _timeAlmostOver = false;
  }



  static format(Duration d) => (Duration(minutes: _timeLimit) - d)
      .toString()
      .split('.')
      .first
      .padLeft(8, "0");
}
