import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safari_one/models/animals.dart';

class AlertPage {
  var content = "";
  String action;
  int index;
  BuildContext context;

  AlertPage(this.content) {
    showdialog();
  }

  AlertDialog showdialog() {
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
            this.action = "yes";
            Get.back(result: 'yes');
          },
        ),
        TextButton(
          child: Text('No'),
          onPressed: () {
            this.action = "no";
            Get.back();
          },
        ),
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            this.action = "cancel";
            Get.back();
          },
        ),
      ],
    );
  }
}
