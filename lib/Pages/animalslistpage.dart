import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/Pages/alertpage.dart';
import 'package:safari_one/models/animals.dart';

import 'animaleditpage.dart';

class AnimalsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimalsProvider>(builder: (context, animalsprovider, __) {
      return ListView.separated(
          itemCount: animalsprovider.animalList.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 5,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              key: UniqueKey(),
              title: Text(animalsprovider.animalList[index].name),
              trailing: PopupMenuButton(
                icon: Icon(Icons.more_vert),
                tooltip: 'Redaguoti',
                onSelected: (result) => {menuresult(result, index, context)},
                itemBuilder: (context) => <PopupMenuItem<String>>[
                  const PopupMenuItem<String>(
                      value: "edit", child: Text("Redaguoti")),
                  const PopupMenuItem<String>(
                      value: "delete", child: Text("Trinti")),
                  const PopupMenuItem<String>(
                      value: "up", child: Text("Aukštyn")),
                  const PopupMenuItem<String>(
                      value: "down", child: Text("Žemyn")),
                ],
              ),
            );
          });
    });
  }

  menuresult(String action, int index, BuildContext context) async {
    switch (action) {
      case "edit":
        Navigator.pushNamed(context, "/animaledit/" + index.toString());
        break;
      case "remove":
        AlertPage page = AlertPage(context, "Ar tikrai norite ištrinti");
        await page.showMyDialog();
        if (page.action == "yes") {
          Provider.of<AnimalsProvider>(context).animalList.removeAt(index);
        }
        break;
    }
  }
}
