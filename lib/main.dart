import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/Pages/alertpage.dart';
import 'package:safari_one/Pages/animaldetail.dart';
import 'package:safari_one/Pages/animaleditpage.dart';
import 'package:safari_one/Pages/animalslistpage.dart';
import 'package:safari_one/Pages/authenticate.dart';
import 'package:safari_one/Pages/closingscreen.dart';
import 'package:safari_one/Pages/editpage.dart';
import 'package:safari_one/Pages/homepage.dart';
import 'package:safari_one/Pages/routepage.dart';
import 'package:safari_one/Pages/map_manager.dart';
import 'package:safari_one/models/animalhive.dart';
import 'package:safari_one/models/animals.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:safari_one/models/clockProvider.dart';
import 'package:safari_one/services/NoAnimPageRoute.dart';
import 'package:flutter/services.dart';
import 'package:safari_one/services/geolocation.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/locals.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(AnimalHiveAdapter());

  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final Color _baseColor = Color(0xFFEBE2E3);
  Color get baseColor => _baseColor;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<AnimalsProvider>(
          create: (_) => AnimalsProvider(),
          key: ObjectKey("animal"),
          lazy: false,
        ),
        ListenableProvider<LocaleProvider>(
          create: (_) => LocaleProvider(),
          key: ObjectKey('locale'),
          lazy: false,
        ),
        ListenableProvider(
          dispose: (context, value) => value.dispose(),
          create: (_) => ClockProvider(),
        ),
      ],
      child: NeumorphicApp(
          debugShowCheckedModeBanner: false,
          title: 'Safari',
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
            "/authentication": (context) => AuthenticatePage(),
            "/editpage": (context) => EditPage(),
            "/newanimal": (context) => AnimalEditPage(),
            "/route": (context) => RoutePage(),
          },
          onGenerateRoute: (RouteSettings values) {
            List<String> routes = values.name.split("/");
            // print(routes.toString());
            String route = routes[1];
            int index = int.parse(routes[2]);
            NoAnimationMaterialPageRoute currentroute;
            // print("Route: $route");
            switch (route) {
              case "animal":
                currentroute = NoAnimationMaterialPageRoute(
                    builder: (BuildContext conext) => AnimalDetail(index));
                break;
              case "animaledit":
                currentroute = NoAnimationMaterialPageRoute(
                    builder: (BuildContext context) =>
                        AnimalEditPage.forEdit(index));
                break;
              default:
                currentroute = NoAnimationMaterialPageRoute(builder: null);
            }
            return currentroute;
            // print("Index: $index");
          }),
    );
  }
}
