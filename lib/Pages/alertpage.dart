import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertPage {
  String content = "";
  String action;
  BuildContext context;

  AlertPage(this.context, this.content);

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
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
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return AlertDialog(
  //     content: Text(content),
  //     actions: [
  //       TextButton(onPressed: () => action = "yes", child: Text("Yes")),
  //       TextButton(onPressed: () => action = "no", child: Text("No")),
  //       TextButton(onPressed: () => action = "cancel", child: Text("Cancel")),
  //     ],
  //   );
  // }
}
