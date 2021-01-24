import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geolocation/geolocation.dart';
import 'package:rive/rive.dart';
import 'package:safari_one/services/geolocation.dart';
import 'package:safari_one/services/position.dart';

class MapNavi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapNaviState();
}

class _MapNaviState extends State<MapNavi> with TickerProviderStateMixin {
  StreamSubscription subscription;
  GeoLoc geoLoc = GeoLoc();

  AnimationController _animationController;
  Animation<double> _animation;
  final random = Random();
  double iconHeight = 30.0;

  Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    // _animationController = AnimationController(
    //   duration: Duration(seconds: 1),
    //   vsync: this,
    // );
    // _animation =
    //     Tween<double>(begin: 50.0, end: 30.0).animate(_animationController);
    // _animationController.forward();

    rootBundle.load('assets/rive/location.riv').then(
      (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation('go'));
          setState(() => _riveArtboard = artboard);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * .8;
    var width = MediaQuery.of(context).size.width;
    return StreamBuilder<List<double>>(
        stream: geoLoc.getgeoloc(Duration(seconds: 3)),
        builder: (context, AsyncSnapshot<List<double>> snapshot) {
          if (!snapshot.hasData) {
            // print("no data" + snapshot.connectionState.toString());
            return Align(
              alignment: Alignment(0, 0),
              child: _riveArtboard == null
                  ? const SizedBox()
                  : Rive(artboard: _riveArtboard),
            );
          } else {
            // print("got data" + snapshot.data.toString());
            List<double> positions = Position.getRelativePositionForInclinedTwo(
                snapshot.data, width, height, iconHeight);
            return Positioned(
              // alignment: Alignment(positions[0], positions[1]),
              // alignment: Alignment(-.975, -1),
              left: positions[0],
              bottom: positions[1],
              child: SizedBox(
                width: 30,
                height: 30,
                child: _riveArtboard == null
                    ? const SizedBox()
                    : Rive(artboard: _riveArtboard),
              ),
              // child: Icon(
              //   Icons.airport_shuttle_outlined,
              //   size: iconHeight,
              //   color: Colors.pink,
              // )
            );
          }
        });
    // );
    // );
  }

  @override
  void dispose() {
    // subscription.cancel();
    geoLoc.cancel();
    // _animationController.dispose();
    super.dispose();
  }
}
