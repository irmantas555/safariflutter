import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/models/animals.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:safari_one/services/loc.dart';
import 'package:safari_one/services/location.dart';
import 'package:safari_one/widgets/flbutontext.dart';
import 'package:velocity_x/velocity_x.dart';

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

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        passed += Duration(seconds: 1);
      });
      whatsleft = format(passed);
      // print(passed.inMilliseconds);
    });
  }

  void _stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

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
      return Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: NeumorphicTheme.baseColor(context),
                image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Color(0x88c8b7b7), BlendMode.color),
                  image: AssetImage("assets/pics/safarifinal.jpg"),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: const Color(0xbbeeeeee),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            offset: Offset(-3, -3),
                            color: Colors.white.withOpacity(.05)),
                        BoxShadow(
                            blurRadius: 3,
                            offset: Offset(3, 3),
                            color: Colors.black.withOpacity(.35)),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        whatsleft,
                        style: TextStyle(
                            color: Color(0xff757575),
                            decoration: TextDecoration.none,
                            fontFamily: "nunitor"),
                      ),
                    ),
                  ),
                  // FlatButton(
                  //     onPressed: () => printlocation(),
                  //     child: FButtonText1("Lokacija")),
                  // Expanded(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.rectangle,
                  //       color: NeumorphicTheme.baseColor(context),
                  //       image: DecorationImage(
                  //         colorFilter:
                  //             ColorFilter.mode(Color(0x88c8b7b7), BlendMode.color),
                  //         image: AssetImage("assets/pics/safarifinal.jpg"),
                  //       ),
                  //     ),
                  //     child: Center(
                  //       child: Icon(Icons.not_listed_location),
                  //     ),
                  //   ),
                  // ),
                  // "Pairinkite gyvūną žemiau kad sužinotute daugiau"
                  //     .marquee(
                  //       textStyle: TextStyle(
                  //           fontSize: 16,
                  //           decoration: TextDecoration.none,
                  //           color: Colors.white10.withOpacity(.7)),
                  //     )
                  //     .h4(context),
                  Expanded(
                    child: Stack(children: [
                      Positioned(
                        top: 200,
                        left: 600,
                        child: Icon(
                          Icons.not_listed_location,
                          size: 40,
                          color: NeumorphicTheme.accentColor(context),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xaaeeeeee),
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
                      context, "/animal/" + index.toString()),
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
                        color: Color(0xff757575),
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
      );
    });
  }

  @override
  void initState() {
    _startTimer();
    // infoTrack();
    // getLocation().listen((event) {});
    super.initState();
  }

  @override
  void dispose() {
    _stopTimer();
    _palyerStop();
    subscription.cancel();
    super.dispose();
  }

  Future<void> printlocation() async {
    LocationData locationData = await Locate.getLoc();
    print("Location latitude: " +
        locationData.latitude.toString() +
        " longitude " +
        locationData.longitude.toString());
  }

  Stream<void> getLocation() async* {
    subscription = Loc(Duration(seconds: 5))
        .stream
        .map((locdata) =>
            "longitude: " +
            locdata.longitude.toString() +
            "longitude: " +
            locdata.latitude.toString())
        .listen(
          (event) => print(event),
        );
  }
}
