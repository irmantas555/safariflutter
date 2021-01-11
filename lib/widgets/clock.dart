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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (null == ClockProvider.idle || ClockProvider.idle == true) {
        print("starting clock provider");
        ClockProvider();
        ClockProvider.start();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ClockProvider.timeOver == true) {
      Future.microtask(
          () => Navigator.pushReplacementNamed(context, "/goodBye"));
    }
    return GestureDetector(
      onLongPress: () => ClockProvider.stop(),
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 25, 0, 0),
        width: 250,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: ClockProvider.timeAlmostOver == true
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
          child: StreamBuilder<String>(
              stream: Stream.periodic(Duration(seconds: 1), (x) => x)
                  .map((v) => ClockProvider.whatsleft),
              builder: (context, snapshot) {
                return Text(
                  // "sdfg",
                  snapshot.hasData ? snapshot.data : ClockProvider.whatsleft == null? "00:00:00",
                  style: TextStyle(
                      color: Color(0xff757575),
                      decoration: TextDecoration.none,
                      fontFamily: "nunitor"),
                );
              }),
        ),
      ),
    );
  }

// @override
// void dispose() {
//   // super.dispose();
//   ClockProvider.stop();
// }
}
