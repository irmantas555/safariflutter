import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class FButtonText1 extends StatelessWidget {
  final String text;

  FButtonText1(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: 24,
          fontFamily: "nunitor",
          color: NeumorphicTheme.accentColor(context)),
    );
  }
}
