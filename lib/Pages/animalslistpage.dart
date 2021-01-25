import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/Pages/alertpage.dart';
import 'package:safari_one/models/animals.dart';

import 'animaleditpage.dart';

class AnimalsListPage extends StatelessWidget {
  final AnimalsGetter animalsGetter = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: animalsGetter.animallist.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 5,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            key: UniqueKey(),
            title: Obx(() => Text(animalsGetter.animallist[index].name)),
            trailing: PopupMenuButton(
              icon: Icon(Icons.more_vert),
              tooltip: 'Redaguoti',
              onSelected: (result) => {
                if (result == "edit")
                  {
                    Navigator.pushNamed(
                        context, "/animaledit/" + index.toString())
                  }
                else if (result == "delete")
                  {
                    AnimalsGetter().remove(index),
                  },
              },
              itemBuilder: (context) => <PopupMenuItem<String>>[
                const PopupMenuItem<String>(
                    value: "edit", child: Text("Redaguoti")),
                const PopupMenuItem<String>(
                    value: "delete", child: Text("Trinti")),
              ],
            ),
          );
        });
  }

  AlertDialog showdialog(BuildContext context, String content, int index) {
    return AlertDialog(
      title: Text("Įspėjimas"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(content),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Yes'),
          onPressed: () {
            AnimalsGetter().remove(index);
          },
        ),
        TextButton(
          child: Text('No'),
          onPressed: () {},
        ),
        TextButton(
          child: Text('Cancel'),
          onPressed: () {},
        ),
      ],
    );
  }
}
