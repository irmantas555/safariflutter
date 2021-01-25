import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AuthenticatePage extends StatefulWidget {
  AuthenticatePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthenticatePage> {
  final _formKey = GlobalKey<FormState>();
  var preferences = Hive.box('prefs');
  int tries = 0;

  @override
  Widget build(BuildContext context) {
    print(preferences.get('password'));
    return Center(
        child: Card(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        height: MediaQuery.of(context).size.height * .6,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Įvęsk slaptažodį',
                  ),
                  onSaved: (String value) {
                    if (value == preferences.get("password") && tries < 3) {
                      Navigator.pushReplacementNamed(context, "/editpage");
                    } else if (tries < 3) {
                      setState(() {
                        tries++;
                      });
                    } else {
                      Get.back();
                    }
                  },
                  // validator: (value) {
                  //   if (value == 'slaptas321') {
                  //     return null;
                  //   }
                  // },
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState.save();
                    },
                    child: Text("Įvesti"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
