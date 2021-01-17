import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

class ClockProvider extends ChangeNotifier {
  static final _cloockporvider = ClockProvider._internal();
  int _timeLimit;
  int _timeFinishes;
  bool _timeAlmostOver;
  bool _timeOver;
  bool _paused;
  String _whatsleft;
  Duration _passed;
  bool _idle = true;
  static Timer _timer;

  factory ClockProvider() {
    return _cloockporvider;
  }

  ClockProvider._internal() {
    // print("internal started");
  }

  String get whatsleft => _whatsleft;

  bool get idle => _idle;

  bool get timeAlmostOver => _timeAlmostOver;

  bool get timeOver => _timeOver;

  Duration get passed => _passed;

  int get timeLimit => _timeLimit;

  int get timeFinishes => _timeFinishes;

  bool get paused => _paused;

  static void unpause(int timelmt, int timeLimitWarningBefore) {
    _cloockporvider._paused = false;
    _cloockporvider._passed = Duration(seconds: 0);
    _cloockporvider._timeLimit = timelmt;
    _cloockporvider._timeFinishes = timeLimitWarningBefore;
    _cloockporvider._timeAlmostOver = false;
    _cloockporvider._whatsleft = '00:0' + timelmt.toString() + ':00';
    _cloockporvider._idle = false;
    _cloockporvider._timeOver = false;
    _cloockporvider._startTimer();
  }

  void _startTimer() {
    if (null == _timer || _timer.isActive == false) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        startSequence(true);
      });
    } else {
      startSequence(false);
    }
  }

  void startSequence(bool addDuration) {
    if (addDuration) {
      _passed += Duration(seconds: 1);
    }
    _whatsleft = format(_passed);
    if (_passed.inMinutes.abs() >= timeLimit - timeFinishes) {
      _timeAlmostOver = true;
    }
    if (_passed.inMinutes.abs() >= timeLimit) {
      _timeOver = true;
    }
    // print("tick" + _passed.inSeconds.toString());
    notifyListeners();
  }

  void stop() {
    // print("stop pressed");
    // _timer.cancel();
    _idle = true;
    notifyListeners();
  }

  void closing() {
    _timer.cancel();
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    // print(listener.toString());
  }

  static format(Duration d) =>
      (Duration(minutes: _cloockporvider._timeLimit) - d)
          .toString()
          .split('.')
          .first
          .padLeft(8, "0");
}
