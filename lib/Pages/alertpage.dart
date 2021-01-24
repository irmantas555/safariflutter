import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safari_one/models/animals.dart';

class AlertPage{
  var content = "";
  String action;
  int index;
  BuildContext context;

  AlertPage(this.context, this.content, this.index){
    showdialog();
  }

 AlertDialog showdialog(){
    return  AlertDialog(
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
                  AnimalsProvider().remove(index);
                },
              ),
              TextButton(
                child: Text('No'),
                onPressed: () {
                  this.action = "no";
                },
              ),
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  this.action = "cancel";
                },
              ),
            ],
          );

  }

}
