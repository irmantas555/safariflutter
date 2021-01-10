import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safari_one/models/timer.dart';

class HomePage extends StatelessWidget {
  final Color _tapColor = Colors.pinkAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Center(
        child: Column(
          children: [
            Spacer(
              flex: 20,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(
                  MediaQuery.of(context).size.width * 0.6,
                  MediaQuery.of(context).size.height)),
              child: Image.asset(
                "assets/pics/safaribanner.png",
                fit: BoxFit.contain,
              ),
            ),
            Spacer(),
            NeumorphicButton(
              margin: EdgeInsets.only(top: 20),
              onPressed: () {
                print(Navigator.pushNamed(context, '/mapman'));
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Pradėti",
                style: TextStyle(
                    color: NeumorphicTheme.accentColor(context),
                    fontSize: MediaQuery.of(context).size.width * .03),
              ),
            ),
            Spacer(
              flex: 20,
            ),
          ],
        ),
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
