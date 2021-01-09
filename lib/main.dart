import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/Pages/animaldetail.dart';
import 'package:safari_one/Pages/homepage.dart';
import 'package:safari_one/map_manager.dart';
import 'package:safari_one/models/animals.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color _baseColor = Color(0xFFe6ebf2);

  Color get baseColor => _baseColor;
  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (_) async => AnimalsProvider(),
      lazy: false,
      child: NeumorphicApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: ThemeMode.light,
          theme: NeumorphicThemeData(
            baseColor: _baseColor,
            accentColor: Colors.pinkAccent,
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
          },
          onGenerateRoute: (RouteSettings values) {
            String index = values.name.split("/")[2];
            print("Index: $index");
            return MaterialPageRoute(
                builder: (BuildContext conext) =>
                    AnimalDetail(int.parse(index)));
          }),
    );
  }
}

// PREVIOUS HOME WITHOUT NAVIGATION
// home: Scaffold(
// appBar: AppBar(
// centerTitle: true,
// backgroundColor: Color(0xFF441A39),
// title: Text("Safari First Test"),
// ),
// body: MapManager(),
// ),
