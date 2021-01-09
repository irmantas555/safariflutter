import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/models/animals.dart';
import 'package:safari_one/widgets/flbutontext.dart';

class AnimalDetail extends StatefulWidget {
  int id;

  AnimalDetail(this.id);

  @override
  State<StatefulWidget> createState() {
    return _AnimalDetailState();
  }
}

class _AnimalDetailState extends State<AnimalDetail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimalsProvider>(builder: (context, amimalsprovider, _) {
      return Padding(
          padding: EdgeInsets.fromLTRB(120, 80, 80, 150),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xff7c94b6),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Color(0xaac8b7b7), BlendMode.color),
                image:
                    AssetImage(amimalsprovider.animalList[widget.id].imagePath),
                fit: BoxFit.fitWidth,
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    offset: Offset(-3, -3),
                    color: Colors.white.withOpacity(.15)),
                BoxShadow(
                    blurRadius: 3,
                    offset: Offset(3, 3),
                    color: Colors.black.withOpacity(.35)),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    amimalsprovider.animalList[widget.id].name,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      backgroundColor: Colors.white.withOpacity(.8),
                      fontFamily: "nunitor",
                      fontSize: 40,
                      // color: Color(0xFF3E3E3E),
                      color: NeumorphicTheme.accentColor(context),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                ButtonBar(
                  buttonHeight: 25.0,
                  alignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                        color: Colors.white,
                        onPressed: () {
                          if (widget.id + 1 <
                              amimalsprovider.animalList.length) {
                            return Navigator.pushReplacementNamed(context,
                                "/animal/" + (widget.id + 1).toString());
                          } else {
                            return AlertDialog(
                              title: Text("Daugau gyvunėlių nėra"),
                              actions: [
                                FlatButton(onPressed: null, child: Text("Ok"))
                              ],
                            );
                          }
                        },
                        child: FButtonText1(
                          "Sekantis",
                        )),
                    FlatButton(
                        color: Colors.white.withOpacity(.8),
                        onPressed: () => Navigator.pop(context),
                        child: FButtonText1(
                          "Grįžti",
                        )),
                  ],
                )
              ],
            ),
          ));
    });
  }
}
