import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rive/rive.dart';
import 'package:safari_one/models/animals.dart';
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
    Get.put(LocaleGetter());
    Get.put(AnimalsGetter());
    getPrefs();
    getLoaded();
  }

  String currentLocale = "lt";

  @override
  Widget build(BuildContext context) {
    final LocaleGetter locale = Get.find();
    final double textHeight =
        (MediaQuery.of(context).size.height * .15).round().toDouble();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        body: Stack(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onLongPress: () => Get.toNamed("/authentication"),
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
            Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onLongPress: () => SystemNavigator.pop(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: textHeight * 2.5,
                      height: textHeight,
                      child: Container(
                        decoration: BoxDecoration(
                            color: NeumorphicTheme.baseColor(context)),
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
                      currentLocale != "lt"
                          ? FlatButton(
                              onPressed: () => {
                                    locale.changeLocaleList("lt"),
                                    changeTo("lt"),
                                  },
                              child: getText("Lietuviškai", textHeight))
                          : SizedBox.shrink(),
                      currentLocale != "en"
                          ? FlatButton(
                              onPressed: () => {
                                    locale.changeLocaleList("en"),
                                    changeTo("en"),
                                  },
                              child: getText("In English", textHeight))
                          : SizedBox.shrink(),
                      currentLocale != "ru"
                          ? FlatButton(
                              onPressed: () => {
                                    locale.changeLocaleList("ru"),
                                    changeTo("ru"),
                                  },
                              child: getText("По Руский", textHeight))
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
                      ClockGetter.unpause();
                      Get.offNamed('/mapman');
                    },
                    child: GetX<LocaleGetter>(
                      builder: (controller) => Text(controller.current_list[0],
                          style: getStyle(textHeight)),
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
      ),
    );
  }

  void getLoaded() async {
    await LocaleGetter.loaded;
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
    await Hive.openBox('times');
    Get.put(ClockGetter());
  }

  Widget getText(String text, double textHeight) {
    return Text(
      text,
      style: getStyle(textHeight),
    );
  }

  TextStyle getStyle(double textHeight) {
    return TextStyle(
      color: Colors.deepOrangeAccent,
      fontFamily: "nunitor",
      fontSize: textHeight * 0.3,
    );
  }
}
