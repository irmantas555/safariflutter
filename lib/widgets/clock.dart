import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/models/clockProvider.dart';

class Clock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  bool so = true;

  @override
  void initState() {
    if (context.read<ClockProvider>().idle == true) {
      print("checked");
      context.read<ClockProvider>().start();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<ClockProvider>().timeOver) {
      Navigator.pushReplacementNamed(context, "/goodBye");
    }
    return GestureDetector(
      onLongPress: () => context.read<ClockProvider>().stop(),
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 25, 0, 0),
        width: 250,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: context.watch<ClockProvider>().timeAlmostOver == true
              ? Colors.pink
              : Colors.white.withOpacity(.8),
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
            context.watch<ClockProvider>().whatsleft,
            style: TextStyle(
                color: Color(0xff757575),
                decoration: TextDecoration.none,
                fontFamily: "nunitor"),
          ),
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
