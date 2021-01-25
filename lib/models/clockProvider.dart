import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:safari_one/Pages/closingscreen.dart';
import 'package:safari_one/Pages/homepage.dart';
import 'package:safari_one/Pages/map_manager.dart';

class ClockGetter extends GetxController {
  static final _cloockporvider = ClockGetter._internal();
  int _timeLimit;
  int _timeFinishes;
  final timeAlmostOver = RxBool();
  final timeOver = RxBool();
  bool _paused;
  var _whatsleft = "".obs;
  Duration _passed;
  final idle = RxBool(true);
  static Timer _timer;
  static Box prefbox;
  static int prefLimit;
  static final player = AudioPlayer();

  factory ClockGetter() {
    return _cloockporvider;
  }

  void setPrefs() {
    prefbox = Hive.box('prefs');
    if (prefbox.get('timeLimit') != null) {
      _timeLimit = prefbox.get('timeLimit');
      _timeFinishes = prefbox.get('timeFinishes');
      // _timeLimit = 20;
      // _timeFinishes = 10;
      print("From prefs limit: $_timeLimit, finishes $_timeFinishes");
      prefLimit = _timeLimit;
    } else {
      _timeLimit = 5;
      _timeFinishes = 1;
      print("Initial limit: $_timeLimit, finishes $_timeFinishes");
      prefLimit = _timeLimit;
      prefbox.put('timeLimit', 5);
      prefbox.put('timeFinishes', 1);
    }
    if (prefbox.get('password') == null) {
      prefbox.put('password', 'safari321');
    }
  }

  void setLimit(int limit) {
    prefbox.put('timeLimit', limit);
    _timeLimit = limit;
  }

  bool setFinishes(int limit) {
    if (limit < _timeLimit) {
      prefbox.put('timeFinishes', limit);
      _timeFinishes = limit;
      print("Initial limit: $_timeLimit, finishes $_timeFinishes");
      return true;
    } else {
      prefbox.put('timeFinishes', _timeLimit - 1);
      _timeFinishes = _timeLimit - 1;
      return false;
    }
  }

  ClockGetter._internal() {
    setPrefs();
    // print("internal started");
  }

  String get whatsleft => _whatsleft.value;

  // bool get idle => _idle.value;

  // bool get timeAlmostOver => _timeAlmostOver.value;

  // bool get timeOver => _timeOver.value;

  Duration get passed => _passed;

  int get timeLimit => _timeLimit;

  int get timeFinishes => _timeFinishes;

  bool get paused => _paused;

  static void unpause() async {
    _cloockporvider._paused = false;
    _cloockporvider._passed = Duration(seconds: 0);
    _cloockporvider.timeAlmostOver.value = false;
    _cloockporvider._whatsleft('00:0' + prefLimit.toString() + ':00');
    _cloockporvider.idle.value = false;
    _cloockporvider.timeOver.value = false;
    infoTrack();
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
    _whatsleft(format(_passed));
    if (_passed.inMinutes.abs() >= timeLimit - timeFinishes) {
      if (!timeAlmostOver.value) {
        timeAlmostOver.value = true;
        Get.off(MapManager());
      }
    }
    if (_passed.inMinutes.abs() >= timeLimit) {
      if (!timeOver.value) {
        Get.off(ClosingScreen());
        timeOver.value = true;
      }
    }
    // print("tick" + _passed.inSeconds.toString());
  }

  void stop() {
    print("stop pressed");
    if (player.playing) {
      _palyerStop();
    }
    _timer.cancel();
    idle.value = true;
    Get.off(HomePage());
    print("idle value: " + idle.value.toString());
  }

  void closing() {
    _timer.cancel();
  }

  static format(Duration d) =>
      (Duration(minutes: _cloockporvider._timeLimit) - d)
          .toString()
          .split('.')
          .first
          .padLeft(8, "0");

  static void infoTrack() async {
    await player.setAsset('assets/audio/deer.mp3');
    await player.play();
  }

  static void _palyerStop() {
    player.stop();
  }
}
