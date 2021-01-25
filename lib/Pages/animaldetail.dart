import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:safari_one/Pages/map_manager.dart';
import 'package:safari_one/models/animals.dart';
import 'package:safari_one/models/clockProvider.dart';
import 'package:safari_one/models/locals.dart';
import 'package:safari_one/widgets/clock.dart';

class AnimalDetail extends StatelessWidget {
  final int id;

  AnimalDetail() : id = int.parse(Get.parameters['value']);

  @override
  Widget build(BuildContext context) {
    final ClockGetter clockGetter = Get.find();
    final RxString myLocale = LocaleGetter.currentLocale;
    bool moved = false;
    final AnimalsGetter animalsGetter = Get.find();
    final double iconHeight =
        (MediaQuery.of(context).size.height / 15).round().toDouble();
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter:
                ColorFilter.mode(Color(0xff1c1c1c), BlendMode.multiply),
            image: AssetImage("assets/pics/safarifinalForUse.jpg"),
            fit: BoxFit.scaleDown,
          ),
        ),
        child: Stack(children: [
          Row(
            children: [
              Flexible(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 100.0, 5.0, 5.0),
                  child: ListView(
                    children: [
                      Text(
                        myLocale == "lt"
                            ? animalsGetter.animallist[id].description
                            : myLocale == "ru"
                                ? animalsGetter.animallist[id].descriptionRu
                                : animalsGetter.animallist[id].descriptionEn,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Kavivanar",
                            fontSize: iconHeight * .5,
                            color: Colors.white),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 12,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.centerRight,
                        colorFilter: ColorFilter.mode(
                            Color(0xaac8b7b7), BlendMode.color),
                        image: AssetImage(animalsGetter.activeAnimal.imagePath),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Column(
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            myLocale == "lt"
                                ? animalsGetter.animallist[id].name
                                : myLocale == "ru"
                                    ? animalsGetter.animallist[id].nameRu
                                    : animalsGetter.animallist[id].nameEn,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                // fontFamily: "nunitor",
                                fontSize: iconHeight * 0.8,
                                color: Colors.white
                                // color: NeumorphicTheme.accentColor(context),
                                ),
                          ),
                        ),
                        Spacer(
                          flex: 10,
                        ),
                        ButtonBar(
                          buttonHeight: iconHeight * 1.4,
                          alignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                              padding: EdgeInsets.all(5.0),
                              shape: CircleBorder(),
                              elevation: 3,
                              color: Colors.white,
                              onPressed: () {
                                if (!moved) {
                                  animalsGetter.setCurrent(id);
                                  moved = true;
                                }
                                animalsGetter.previous();
                                return Get.offAndToNamed("/animal/" +
                                    (animalsGetter.activeAnimalIndex)
                                        .toString());
                              },
                              child: Icon(
                                Icons.navigate_before,
                                color: NeumorphicTheme.accentColor(context),
                                size: iconHeight * 1.4,
                              ),
                            ),
                            RaisedButton(
                              padding: EdgeInsets.all(5.0),
                              shape: CircleBorder(),
                              elevation: 3,
                              color: Colors.white,
                              onPressed: () {
                                if (!moved) {
                                  animalsGetter.setCurrent(id);
                                  moved = true;
                                }
                                animalsGetter.next();
                                return Get.offAndToNamed("/animal/" +
                                    (animalsGetter.activeAnimalIndex)
                                        .toString());
                              },
                              child: Icon(
                                Icons.navigate_next,
                                color: NeumorphicTheme.accentColor(context),
                                size: iconHeight * 1.4,
                              ),
                            ),
                            RaisedButton(
                                padding: EdgeInsets.all(5.0),
                                shape: CircleBorder(),
                                elevation: 8,
                                color: Colors.white,
                                onPressed: () {
                                  // print("Close pressed");
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.close_rounded,
                                  color: NeumorphicTheme.accentColor(context),
                                  size: iconHeight * 1.4,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Align(alignment: Alignment(-1, -1), child: Clock()),
        ]),
      ),
    );
  }
}
