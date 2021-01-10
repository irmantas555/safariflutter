import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:location/location.dart';
import 'package:safari_one/services/loc.dart';
import 'package:safari_one/services/location.dart';
import 'package:safari_one/services/position.dart';

class MapNavi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapNaviState();
}

class _MapNaviState extends State<MapNavi> {
  StreamSubscription subscription;
  // @override
  // void initState() {
  //   getLocation().listen((event) {});
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocationData>(
        stream: Loc(Duration(seconds: 5)).stream,
        builder: (context, AsyncSnapshot<LocationData> snapshot) {
          if (!snapshot.hasData) {
            return Align(
              alignment: Alignment(0, 0),
              child: Icon(
                Icons.not_listed_location,
                size: 40,
                color: NeumorphicTheme.accentColor(context),
              ),
            );
          } else {
            List<double> positions =
                Position.getRelativePositionForAlign(snapshot.data);
            print(positions);
            return Align(
              alignment: Alignment(positions[0], positions[1]),
              child: Icon(
                Icons.not_listed_location,
                size: 40,
                color: NeumorphicTheme.accentColor(context),
              ),
            );
          }
        });
    // );
    // );
  }

  Future<void> printlocation() async {
    LocationData locationData = await Locate.getLoc();
    print("Location latitude: " +
        locationData.latitude.toString() +
        " longitude " +
        locationData.longitude.toString());
  }

  // Stream<void> getLocation() async* {
  //   subscription = Loc(Duration(seconds: 5))
  //       .stream
  //       .map((locdata) =>
  //           "longitude: " +
  //           locdata.longitude.toString() +
  //           "longitude: " +
  //           locdata.latitude.toString())
  //       .listen(
  //         (event) => print(event),
  //       );
  // }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
