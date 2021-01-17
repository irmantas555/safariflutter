import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/Pages/closingscreen.dart';
import 'package:safari_one/Pages/homepage.dart';
import 'package:safari_one/Pages/map_manager.dart';
import 'package:safari_one/models/clockProvider.dart';

class RoutePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  Widget build(BuildContext context) {
    // var timesUp = context.watch<ClockProvider>().timeOver;
    // var paused = context.watch<ClockProvider>().idle;
    // print(timesUp.toString() + " + " + paused.toString());
    if (mounted) {
      var timesUp = context
          .select((ClockProvider clockProvider) => clockProvider.timeOver);
      var paused =
          context.select((ClockProvider clockProvider) => clockProvider.idle);
      if (!timesUp && !paused) {
        return MapManager();
      } else if (timesUp && !paused) {
        return ClosingScreen();
      } else {
        return HomePage();
      }
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
