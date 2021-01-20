import 'package:flutter/material.dart';

class AuthenticatePage extends StatefulWidget {
  AuthenticatePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthenticatePage> {
  final _formKey = GlobalKey<FormState>();
  int tries = 0;

  @override
  Widget build(BuildContext context) {
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
                  decoration: const InputDecoration(
                    hintText: 'Įvęsk slaptažodį',
                  ),
                  onSaved: (String value) {
                    // if (value == 'slaptas321' && tries < 3) {
                    Navigator.pushReplacementNamed(context, "/editpage");
                    // } else if (tries < 3) {
                    //   setState(() {
                    //     tries++;
                    //   });
                    // } else {
                    //   Navigator.pop(context);
                    // }
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
