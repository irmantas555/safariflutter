import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:safari_one/models/animals.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:safari_one/models/clockProvider.dart';
import 'package:safari_one/widgets/clock.dart';
import 'package:safari_one/widgets/mapnavi.dart';

class MapManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double bottomHeight =
        (MediaQuery.of(context).size.height * .2).round().toDouble();
    final AnimalsGetter animalsGetter = Get.find();
    return new WillPopScope(
      onWillPop: () async => false,
      child: Container(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * .8,
                // width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: NeumorphicTheme.baseColor(context),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Color(0xaac8b7b7), BlendMode.softLight),
                    image: AssetImage("assets/pics/safarifinalForUse.jpg"),
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Stack(
                  children: [
                    Align(alignment: Alignment(1, -1), child: Clock()),
                    MapNavi(),
                  ],
                )),
            Container(
              height: bottomHeight,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: NeumorphicTheme.baseColor(context),
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                itemCount: animalsGetter.animallist.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 5,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => {
                      if (!ClockGetter().timeAlmostOver.value)
                        {
                          animalsGetter.setCurrent(index),
                          Get.toNamed("/animal/" + index.toString())
                        }
                    },
                    child: Container(
                      height: bottomHeight * .8,
                      width: bottomHeight * .8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xff7c94b6),
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Color(0xaac8b7b7), BlendMode.color),
                          image: AssetImage(
                              animalsGetter.animallist[index].imagePath),
                          fit: BoxFit.fitHeight,
                        ),
                        border: Border.all(
                          color: NeumorphicTheme.accentColor(context),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1,
                              offset: Offset(-3, -3),
                              color: Colors.white.withOpacity(.15)),
                          BoxShadow(
                              blurRadius: 3,
                              offset: Offset(3, 3),
                              color: Colors.black.withOpacity(.35)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
