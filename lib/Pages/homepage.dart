import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rive/rive.dart';
import 'package:safari_one/models/clockProvider.dart';
import 'package:safari_one/models/locale.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onLongPress: () =>
                    Navigator.pushNamed(context, "/authentication"),
                child: SizedBox(
                  width: 120,
                  height: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pink,
                    ),
                  ),
                ),
              )),
          Center(
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
                ButtonBar(
                  children: [
                    FlatButton(
                        onPressed: () => MyLocale.locale = "ru",
                        child: Text("Po ruski")),
                    FlatButton(
                        onPressed: () => MyLocale.locale = "en",
                        child: Text("In English")),
                  ],
                ),
                Spacer(),
                NeumorphicButton(
                  margin: EdgeInsets.only(top: 20),
                  onPressed: () {
                    ClockProvider.unpause(5, 1);
                    Navigator.pushReplacementNamed(context, '/route');
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(10.0)),
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
        ],
      ),
    );
  }
}
