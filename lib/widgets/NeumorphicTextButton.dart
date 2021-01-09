
 import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NTButton extends StatelessWidget{
  Color _tapColor = Colors.pinkAccent;
  Function action;
  String text;


  NTButton(this.action, this.text);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      margin: EdgeInsets.only(top: 20),
      onPressed: action,
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Text(text, style: TextStyle(color: _tapColor, fontSize: 40),),
    );
  }

}