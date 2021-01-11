import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:safari_one/widgets/clock.dart';

class ClosingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: NeumorphicTheme.baseColor(context),
        ),
        child: Column(
          children: [
            Spacer(
              flex: 10,
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
            Spacer(flex: 5),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                "Ačiū kad apsilankėte, iki kitų susitikimų",
                style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    decoration: TextDecoration.none,
                    fontFamily: "nunitor",
                    fontSize: MediaQuery.of(context).size.height * .08),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
