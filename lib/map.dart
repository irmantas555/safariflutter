import 'package:flutter/material.dart';

class MapUnit extends StatelessWidget {
  final List<String> stringList;

  MapUnit(this.stringList);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: stringList
          .map((e) => Card(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/100.jpg",
                      width: 300,
                      height: 240,
                      fit: BoxFit.fitWidth,
                    ),
                    Text(e)
                  ],
                ),
              ))
          .toList(),
    );
  }
}
