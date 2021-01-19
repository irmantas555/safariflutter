import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/Pages/animaldetail.dart';
import 'package:safari_one/Pages/authenticate.dart';
import 'package:safari_one/Pages/closingscreen.dart';
import 'package:safari_one/Pages/editpage.dart';
import 'package:safari_one/Pages/homepage.dart';
import 'package:safari_one/Pages/routepage.dart';
import 'package:safari_one/Pages/map_manager.dart';
import 'package:safari_one/models/animals.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:safari_one/models/clockProvider.dart';
import 'package:safari_one/services/NoAnimPageRoute.dart';
import 'package:flutter/services.dart';
import 'package:safari_one/services/geolocation.dart';

void main() {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final Color _baseColor = Color(0xaaeeeeee);

  Color get baseColor => _baseColor;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (_) async => AnimalsProvider(),
          key: ObjectKey("animal"),
          lazy: false,
        ),
        ListenableProvider(
          dispose: (context, value) => value.dispose(),
          create: (_) => ClockProvider(),
        ),
      ],
      child: NeumorphicApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: ThemeMode.light,
          theme: NeumorphicThemeData(
            baseColor: _baseColor,
            accentColor: Colors.deepOrangeAccent,
            lightSource: LightSource.topLeft,
            depth: 3,
          ),
          darkTheme: NeumorphicThemeData(
            baseColor: Color(0xFF3E3E3E),
            lightSource: LightSource.topLeft,
            depth: 6,
          ),
          routes: {
            "/": (context) => HomePage(),
            "/mapman": (context) => MapManager(),
            "/goodBye": (context) => ClosingScreen(),
            "authentication": (context) => AuthenticatePage(),
            "editpage": (context) => EditPage(),
            "/route": (context) => RoutePage(),
          },
          onGenerateRoute: (RouteSettings values) {
            String index = values.name.split("/")[2];
            // print("Index: $index");
            return NoAnimationMaterialPageRoute(
                builder: (BuildContext conext) =>
                    AnimalDetail(int.parse(index)));
          }),
    );
  }
}
