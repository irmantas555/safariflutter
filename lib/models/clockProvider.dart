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
  static int _timeLimit;
  static int _timeFinishes;
  static final timeAlmostOver = RxBool();
  static final timeOver = RxBool();
  static bool _paused;
  static final _whatsleft = "00:05:00".obs;
  static Duration _passed;
  static Timer _timer;
  static Box prefbox;
  static int prefLimit;
  static final player = AudioPlayer();
  static Box timeleftOvers;
  static var ltimeleftOversValue;
  factory ClockGetter() {
    return _cloockporvider;
  }

  void setPrefs() {
    timeleftOvers = Hive.box('times');
    prefbox = Hive.box('prefs');
    ltimeleftOversValue = timeleftOvers.get('timeleft');
    if (prefbox.get('timeLimit') != null) {
      if (thereIsNoLeftOvers()) {
        _timeLimit = prefbox.get('timeLimit') * 60;
      } else {
        _timeLimit = prefbox.get('timeLimit') * 60 -
            Duration(seconds: ltimeleftOversValue).inSeconds;
      }
      _timeFinishes = prefbox.get('timeFinishes') * 60;
      prefLimit = prefbox.get('timeLimit');
    } else {
      _timeLimit = 300;
      _timeFinishes = 60;
      // print("Initial limit: $_timeLimit, finishes $_timeFinishes");
      prefLimit = _timeLimit;
      prefbox.put('timeLimit', 5);
      prefbox.put('timeFinishes', 1);
    }
    // print("time limit: $timeLimit");
    // print("timefinishes: $timeFinishes");
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
      prefbox.put('timeFinishes', _timeLimit / 60 - 1);
      _timeFinishes = _timeLimit - 60;
      return false;
    }
  }

  ClockGetter._internal() {
    setPrefs();
    // print("internal started");
  }

  static String get whatsleft => _whatsleft.value;

  Duration get passed => _passed;

  int get timeLimit => _timeLimit;

  int get timeFinishes => _timeFinishes;

  bool get paused => _paused;

  static void unpause() async {
    _paused = false;
    _passed = Duration(seconds: 0);
    _whatsleft('00:0' + prefLimit.toString() + ':00');
    print("ltimeleftOversValue " + ltimeleftOversValue.toString());
    print("thereIsNoLeftOvers " + thereIsNoLeftOvers().toString());
    if (!thereIsNoLeftOvers()) {
      if (ltimeleftOversValue > prefLimit * 60) {
        timeAlmostOver(true);
        timeOver(true);
      } else if (ltimeleftOversValue >
          prefLimit * 60 - _cloockporvider.timeFinishes) {
        timeAlmostOver(true);
        timeOver(false);
      } else {
        timeAlmostOver(false);
        timeOver(false);
      }
    } else {
      ltimeleftOversValue = 0;
      timeAlmostOver(false);
      timeOver(false);
    }
    print("time almost over " + timeAlmostOver.value.toString());
    print("time over " + timeOver.value.toString());
    // infoTrack();
    _cloockporvider._startTimer();
  }

  void _startTimer() {
    if (null == _timer || _timer.isActive == false) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        eachSecond(true);
      });
    }
  }

  void eachSecond(bool addDuration) {
    if (addDuration) {
      _passed += Duration(seconds: 1);
    }

    if (_passed.inSeconds % 10 == 0) {
      // print("writing timeleft: " + _passed.inSeconds.toString());
      timeleftOvers.put('timeleft', _passed.inSeconds + ltimeleftOversValue);
    }

    _whatsleft(format(_passed));
    if (_passed.inSeconds.abs() >= timeLimit - timeFinishes) {
      if (!timeAlmostOver.value) {
        timeAlmostOver(true);
        Get.off(MapManager());
      }
    }
    if (_passed.inSeconds.abs() >= timeLimit) {
      if (!timeOver.value) {
        timeOver(true);
        Get.off(ClosingScreen());
      }
    }
  }

  static void stop() {
    // print("stop pressed");
    if (player.playing) {
      _palyerStop();
    }
    timeleftOvers.put('timeleft', 0);
    ltimeleftOversValue = 0;
    _timeLimit = prefbox.get('timeLimit') * 60;
    _timer.cancel();
    Get.off(HomePage());
  }

  void closing() {
    _timer.cancel();
  }

  static format(Duration d) => (Duration(seconds: _timeLimit) - d)
      .toString()
      .split('.')
      .first
      .padLeft(8, "0");

  static void infoTrack() async {
    await player.setAsset('assets/audio/deer.mp3');
    await player.play();
  }

  static bool thereIsNoLeftOvers() {
    return ltimeleftOversValue == null || ltimeleftOversValue == 0;
  }

  static void _palyerStop() {
    player.stop();
  }
}
