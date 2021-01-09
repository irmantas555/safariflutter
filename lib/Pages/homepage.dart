import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safari_one/models/timer.dart';

class HomePage extends StatelessWidget {
  Color _tapColor = Colors.pinkAccent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Container(
            width: 800,
            height: 316,
            child: Image.asset("assets/pics/safaribanner.png"),
          ),
          NeumorphicButton(
            margin: EdgeInsets.only(top: 20),
            onPressed: () {
              print(Navigator.pushNamed(context, '/mapman'));
            },
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Text("Pradėti", style: TextStyle(color: _tapColor, fontSize: 40),),
          ),
        ]),
      ),
    );
  }

  Color _iconsColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (theme.isUsingDark) {
      return theme.current.accentColor;
    } else {
      return null;
    }
  }
}
