import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/models/animals.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:safari_one/widgets/clock.dart';
import 'package:safari_one/widgets/mapnavi.dart';

class MapManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MapManagerState();
  }
}

class _MapManagerState extends State<MapManager> {
  format(Duration d) =>
      (Duration(minutes: 5) - d).toString().split('.').first.padLeft(8, "0");
  String whatsleft = "";
  Duration passed = Duration(seconds: 0);
  Timer _timer;
  final player = AudioPlayer();
  StreamSubscription subscription;

  void infoTrack() async {
    // int result = await player.play("assets/audio/deer.mp3", isLocal: true);
    // int result = await player.play(
    //     "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3");
    var duration = await player.setAsset('assets/audio/deer.mp3');
    await player.play();
  }

  void _palyerStop() {
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimalsProvider>(builder: (context, amimalsprovider, _) {
      return Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                  height: MediaQuery.of(context).size.height - 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      colorFilter:
                          ColorFilter.mode(Color(0xaac8b7b7), BlendMode.color),
                      image: AssetImage("assets/pics/safarifinal.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(alignment: Alignment(-1, -1), child: Clock()),
                      MapNavi(),
                    ],
                  )),
            ),
            Container(
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: NeumorphicTheme.baseColor(context),
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                itemCount: amimalsprovider.animalList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      "/animal/" + index.toString(),
                    ),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xff7c94b6),
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Color(0xaac8b7b7), BlendMode.color),
                          image: AssetImage(
                              amimalsprovider.animalList[index].imagePath),
                          fit: BoxFit.fitWidth,
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
      );
    });
  }

  @override
  void initState() {
    // infoTrack();

    super.initState();
  }

  @override
  void dispose() {
    _palyerStop();
    super.dispose();
  }
}
