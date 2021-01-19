import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:location/location.dart';
import 'package:safari_one/services/geolocation.dart';
import 'package:safari_one/services/loc.dart';
import 'package:safari_one/services/position.dart';

class MapNavi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapNaviState();
}

class _MapNaviState extends State<MapNavi> with TickerProviderStateMixin {
  StreamSubscription subscription;

  AnimationController _animationController;
  Animation<double> _animation;
  final random = Random();
  double iconHeight = 30.0;
  GeoLoc geoLoc;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 50.0, end: 30.0).animate(_animationController);
    _animationController.forward();
    geoLoc = GeoLoc();
  }

  Stream mystream = geoLoc.getgeoloc(Duration(seconds: 3));

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height - 120;
    var width = MediaQuery.of(context).size.width;
    return StreamBuilder<LocationData>(
        stream: mystream,
        builder: (context, AsyncSnapshot<LocationData> snapshot) {
          if (!snapshot.hasData) {
            return Align(
              alignment: Alignment(0, 0),
              child: Icon(
                Icons.airport_shuttle_outlined,
                size: _animation.value,
                color: Colors.pink,
              ),
            );
          } else {
            List<double> positions = Position.getRelativePositionForInclined(
                snapshot.data, width, height, iconHeight);
            // print(positions);
            return Positioned(
                // alignment: Alignment(positions[0], positions[1]),
                // alignment: Alignment(-.975, -1),
                left: positions[0],
                bottom: positions[1],
                child: Icon(
                  Icons.airport_shuttle_outlined,
                  size: iconHeight,
                  color: Colors.pink,
                ));
          }
        });
    // );
    // );
  }

  @override
  void dispose() {
    // subscription.cancel();
    super.dispose();
    _animationController.dispose();
  }
}
