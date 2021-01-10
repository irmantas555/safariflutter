import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  format(Duration d) =>
      (Duration(minutes: 5) - d).toString().split('.').first.padLeft(8, "0");
  String whatsleft = "";
  Duration passed = Duration(seconds: 0);
  Timer _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    this._timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          passed += Duration(seconds: 1);
        });
        whatsleft = format(passed);
        // print(passed.inMilliseconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 25, 0, 0),
      width: 250,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: const Color(0xbbeeeeee),
        boxShadow: [
          BoxShadow(
              blurRadius: 1,
              offset: Offset(-3, -3),
              color: Colors.white.withOpacity(.05)),
          BoxShadow(
              blurRadius: 3,
              offset: Offset(3, 3),
              color: Colors.black.withOpacity(.25)),
        ],
      ),
      child: Center(
        child: Text(
          whatsleft,
          style: TextStyle(
              color: Color(0xff757575),
              decoration: TextDecoration.none,
              fontFamily: "nunitor"),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _stopTimer();
  //   super.dispose();
  // }
}
