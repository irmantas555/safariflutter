import 'dart:async';

import 'package:location/location.dart';

class Loc {
  final Duration duration;
  Location location = new Location();
  // Loc(this.duration);

  final _controller = StreamController<LocationData>();

  Loc(this.duration) {
    Timer.periodic(duration, (timer) async {
      _controller.sink.add(await location.getLocation());
    });
  }

  Stream<LocationData> get stream => _controller.stream;
}
