import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/models/animals.dart';

class AnimalDetail extends StatefulWidget {
  final int id;

  AnimalDetail(this.id);

  @override
  State<StatefulWidget> createState() {
    return _AnimalDetailState();
  }
}

class _AnimalDetailState extends State<AnimalDetail> {
  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    return Consumer<AnimalsProvider>(builder: (context, amimalsprovider, _) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter:
                ColorFilter.mode(Color(0xff1c1c1c), BlendMode.multiply),
            image: AssetImage("assets/pics/safarifinal.jpg"),
            fit: BoxFit.scaleDown,
          ),
        ),
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                  color: NeumorphicTheme.accentColor(context), width: 1),
              image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Color(0xaac8b7b7), BlendMode.color),
                image:
                    AssetImage(amimalsprovider.animalList[widget.id].imagePath),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(
                flex: 1,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      offset: Offset(2, 2),
                      color: Colors.black,
                    )
                  ],
                ),
                child: Text(
                  amimalsprovider.animalList[widget.id].name,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      // fontFamily: "nunitor",
                      fontSize: 40,
                      color: Colors.white
                      // color: NeumorphicTheme.accentColor(context),
                      ),
                ),
              ),
              Spacer(
                flex: 20,
              ),
              ButtonBar(
                buttonHeight: 25.0,
                alignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    padding: EdgeInsets.all(5.0),
                    shape: CircleBorder(),
                    elevation: 3,
                    color: Colors.white,
                    onPressed: () {
                      if (widget.id - 1 > 0) {
                        return Navigator.pushReplacementNamed(
                            context, "/animal/" + (widget.id - 1).toString());
                      } else {
                        return AlertDialog(
                          title: Text("Daugau gyvunėlių nėra"),
                          actions: [
                            FlatButton(onPressed: null, child: Text("Ok"))
                          ],
                        );
                      }
                    },
                    child: Icon(
                      Icons.navigate_before,
                      color: NeumorphicTheme.accentColor(context),
                      size: 40,
                    ),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(5.0),
                    shape: CircleBorder(),
                    elevation: 3,
                    color: Colors.white,
                    onPressed: () {
                      if (widget.id + 1 < amimalsprovider.animalList.length) {
                        return Navigator.pushReplacementNamed(
                            context, "/animal/" + (widget.id + 1).toString());
                      } else {
                        return AlertDialog(
                          title: Text("Daugau gyvunėlių nėra"),
                          actions: [
                            FlatButton(onPressed: null, child: Text("Ok"))
                          ],
                        );
                      }
                    },
                    child: Icon(
                      Icons.navigate_next,
                      color: NeumorphicTheme.accentColor(context),
                      size: 40,
                    ),
                  ),
                  RaisedButton(
                      padding: EdgeInsets.all(5.0),
                      shape: CircleBorder(),
                      elevation: 8,
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close_rounded,
                        color: NeumorphicTheme.accentColor(context),
                        size: 40,
                      )),
                ],
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ]),
      );
    });
  }
}
