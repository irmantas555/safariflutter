import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:location/location.dart';
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

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 1, end: 1.4).animate(_animationController);
    _animationController.forward();
    _animationController.reverse();
    super.initState();
  }

  Stream mystream = Loc(Duration(seconds: 3)).stream;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height - 120;
    var width = MediaQuery.of(context).size.width;
    const iconHeight = 40.0;
    return StreamBuilder<LocationData>(
        stream: mystream,
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
            List<double> positions = Position.getRelativePositionForInclined(
                snapshot.data, width, height, iconHeight);
            // print(positions);
            return Positioned(
                // alignment: Alignment(positions[0], positions[1]),
                // alignment: Alignment(-.975, -1),
                left: positions[0],
                bottom: positions[1],
                child: ScaleTransition(
                  alignment: Alignment.bottomCenter,
                  scale: _animation,
                  child: Icon(
                    Icons.not_listed_location,
                    size: iconHeight,
                    color: NeumorphicTheme.accentColor(context),
                  ),
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
  }
}
