import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:safari_one/models/clockProvider.dart';
import 'package:safari_one/models/locals.dart';
import 'package:safari_one/widgets/starttext.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loaded = false;

  @override
  void initState() {
    getPrefs();
    getLoaded();
  }

  String currentLocale = "lt";

  @override
  Widget build(BuildContext context) {
    final double textHeight =
        (MediaQuery.of(context).size.height * .15).round().toDouble();
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onLongPress: () =>
                    Navigator.pushNamed(context, "/authentication"),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: textHeight * 5,
                    height: textHeight * 2.5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: NeumorphicTheme.baseColor(context),
                      ),
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
                  alignment: MainAxisAlignment.center,
                  children: [
                    currentLocale != "ru"
                        ? FlatButton(
                            onPressed: () => {
                                  context
                                      .read<LocaleProvider>()
                                      .changeLocaleList("ru"),
                                  changeTo("ru"),
                                },
                            child: getText("По Руский", textHeight))
                        : SizedBox.shrink(),
                    currentLocale != "en"
                        ? FlatButton(
                            onPressed: () => {
                                  context
                                      .read<LocaleProvider>()
                                      .changeLocaleList("en"),
                                  changeTo("en"),
                                },
                            child: getText("In English", textHeight))
                        : SizedBox.shrink(),
                    currentLocale != "lt"
                        ? FlatButton(
                            onPressed: () => {
                                  context
                                      .read<LocaleProvider>()
                                      .changeLocaleList("lt"),
                                  changeTo("lt"),
                                },
                            child: getText("Lietuviškai", textHeight))
                        : SizedBox.shrink(),
                  ],
                ),
                NeumorphicButton(
                    margin: EdgeInsets.only(top: 5),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(textHeight)),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    onPressed: () {
                      ClockProvider.unpause();
                      Navigator.pushReplacementNamed(context, '/route');
                    },
                    child: FutureBuilder(
                      future: LocaleProvider.loaded,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        String txt;
                        if (snapshot.hasData) {
                          txt = context.watch<LocaleProvider>().current_list[0];
                        } else {
                          txt = "Pradėti";
                        }
                        return getText(txt, textHeight);
                      },
                    )),
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

  void getLoaded() async {
    await LocaleProvider.loaded;
    setState(() {
      loaded = true;
    });
  }

  changeTo(String s) {
    setState(() {
      currentLocale = s;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getPrefs() async {
    // await Hive.deleteBoxFromDisk('prefs');
    await Hive.openBox('prefs');
  }

  Widget getText(String text, double textHeight) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.deepOrangeAccent,
        fontFamily: "nunitor",
        fontSize: textHeight * 0.3,
      ),
    );
  }
}
