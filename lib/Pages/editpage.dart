import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safari_one/Pages/animalslistpage.dart';
import 'package:safari_one/Pages/prefeditpage.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  int mode = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redagavimo lapas"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 80,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () => Navigator.pushNamed(context, "/newanimal"),
                child: Text("Naujas žvėris")),
            TextButton(
                onPressed: () => changeMode(2),
                child: Text("Redaguoti laikus")),
            TextButton(
                onPressed: () => changeMode(1),
                child: Text("Redaguoti žvėris")),
          ],
        ),
      ),
      body: mode == 1 ? AnimalsListPage() : PrefEditPage(),
    );
  }

  _moveToNew(BuildContext context) {
    ;
  }

  changeMode(int i) {
    setState(() {
      mode = i;
    });
  }
}
