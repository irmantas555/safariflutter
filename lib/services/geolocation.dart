import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';

class GeoLoc {
  List<double> latlong = [55.553875, 25.063695];
  bool active = false;
  StreamSubscription<LocationResult> subscription;
  final StreamController<List<double>> _controller =
      StreamController<List<double>>();

  GeoLoc() {
    init();
    getgeo();
  }

  Future<void> init() async {
    await getService();
    await getPrmission();
  }

  Stream<List<double>> getgeoloc(Duration intreval) {
    active = true;
    _controller.sink.add(latlong);
    // _controller
    //     .addStream(Stream.periodic(Duration(seconds: 1), (seconds) => latlong));
    Stream.periodic(Duration(seconds: 1), (seconds) => latlong)
        .takeWhile((element) => active)
        .listen((event) {
      _controller.sink.add(event);
      if (active) {}
    });
    return _controller.stream;
  }

  getgeo() {
    subscription = Geolocation.locationUpdates(
      accuracy: LocationAccuracy.best,
      displacementFilter: 10.0, // in meters
      inBackground:
          true, // by default, location updates will pause when app is inactive (in background). Set to `true` to continue updates in background.
    ).listen((result) {
      if (result.isSuccessful) {
        latlong[0] = result.location.latitude;
        latlong[1] = result.location.longitude;
      }
    });
  }

  Future<bool> getService() async {
    final GeolocationResult result = await Geolocation.isLocationOperational();
    if (result.isSuccessful) {
      return true;
    } else {
      return false;
    }
  }

  cancel() {
    active = false;
    subscription.cancel();
    _controller.close();
  }

  Future<bool> getPrmission() async {
    final GeolocationResult result =
        await Geolocation.requestLocationPermission(
      permission: const LocationPermission(
        android: LocationPermissionAndroid.fine,
        ios: LocationPermissionIOS.always,
      ),
      openSettingsIfDenied: true,
    );

    if (result.isSuccessful) {
      return true;
    } else {
      return false;
    }
  }
}
