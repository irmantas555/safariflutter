import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safari_one/Pages/animalslistpage.dart';

class EditPage extends StatelessWidget {
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
          ],
        ),
      ),
      body: AnimalsListPage(),
    );
  }

  _moveToNew(BuildContext context) {
    ;
  }
}
