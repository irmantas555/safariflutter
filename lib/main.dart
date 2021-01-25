import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:safari_one/Pages/animaldetail.dart';
import 'package:safari_one/Pages/animaleditpage.dart';
import 'package:safari_one/Pages/authenticate.dart';
import 'package:safari_one/Pages/closingscreen.dart';
import 'package:safari_one/Pages/editpage.dart';
import 'package:safari_one/Pages/homepage.dart';
import 'package:safari_one/Pages/map_manager.dart';
import 'package:safari_one/models/animalhive.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
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
    runApp(GetMaterialApp(
        unknownRoute:
            GetPage(name: '/notfound', page: () => UnknownRoutePage()),
        getPages: [
          GetPage(name: '/', page: () => HomePage()),
          GetPage(name: '/mapman', page: () => MapManager()),
          GetPage(name: '/goodBye', page: () => ClosingScreen()),
          GetPage(name: '/authentication', page: () => AuthenticatePage()),
          GetPage(name: '/editpage', page: () => EditPage()),
          GetPage(name: '/newanimal', page: () => AnimalEditPage()),
          GetPage(name: '/animal/:value', page: () => AnimalDetail()),
          GetPage(
              name: '/animaledit/:value', page: () => AnimalEditPage.forEdit()),
        ],
        initialRoute: '/',
        home: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  final Color _baseColor = Color(0xFFEBE2E3);
  Color get baseColor => _baseColor;
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
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
      home: HomePage(),
    );
  }
}

class UnknownRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("404 Sorry, No such page");
  }
}
