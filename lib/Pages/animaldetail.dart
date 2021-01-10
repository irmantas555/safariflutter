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
    final media_width = MediaQuery.of(context).size.width;
    final media_height = MediaQuery.of(context).size.height;
    return Consumer<AnimalsProvider>(builder: (context, amimalsprovider, _) {
      return Container(
        width: media_width * .9,
        height: media_height * .9,
        decoration: BoxDecoration(
          color: NeumorphicTheme.baseColor(context),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Color(0xaac8b7b7), BlendMode.color),
            image: AssetImage(amimalsprovider.animalList[widget.id].imagePath),
            fit: BoxFit.scaleDown,
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
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(
              flex: 1,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  fontFamily: "nunitor",
                  fontSize: 40,
                  color: Color(0xFF548FAC),
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
                    child: FButtonText1(
                      "Sekantis",
                    )),
                RaisedButton(
                    padding: EdgeInsets.all(5.0),
                    elevation: 3,
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    child: FButtonText1(
                      "Grįžti",
                    )),
              ],
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      );
    });
  }
}
