import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:safari_one/models/clockProvider.dart';

class PrefEditPage extends StatefulWidget {
  @override
  _PrefEditPageState createState() => _PrefEditPageState();
}

class _PrefEditPageState extends State<PrefEditPage> {
  double timesliderValue = ClockProvider().timeLimit.toDouble();
  double timefinishesliderValue = ClockProvider().timeFinishes.toDouble();

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: RectangularSliderTrackShape(),
        trackHeight: 4,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
        thumbColor: NeumorphicTheme.accentColor(context),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
        overlayColor: Colors.deepOrange.withAlpha(16),
        activeTickMarkColor: Colors.deepOrange[700],
        inactiveTickMarkColor: Colors.red[800],
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorColor: Colors.redAccent,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontFamily: "nunitor",
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          _myLabel("Laiko limitas min."),
          _sliderOne(),
          _myLabel("Laiko įspėjimas kai liks min."),
          _sliderTwo(),
        ]),
      ),
    );
  }

  Widget _myLabel(String s) {
    return Text(
      s,
      style: TextStyle(
        fontSize: 20,
        fontFamily: "nunitor",
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange,
      ),
    );
  }

  Widget _sliderOne() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("5"),
        Expanded(
          child: Slider(
              value: timesliderValue,
              label: '$timesliderValue',
              onChanged: (value) {
                setState(() {
                  timesliderValue = value.round().toDouble();
                });
              },
              min: 5,
              max: 60,
              divisions: 11,
              onChangeEnd: (value) {
                ClockProvider().setLimit(value.round().toInt());
              }),
        ),
        Text("60"),
      ],
    );
  }

  Widget _sliderTwo() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("0"),
        Expanded(
          child: Slider(
              value: timefinishesliderValue,
              label: '$timefinishesliderValue',
              onChanged: (value) {
                setState(() {
                  timefinishesliderValue = value.round().toDouble();
                });
              },
              min: 0,
              max: 10,
              divisions: 10,
              onChangeEnd: (value) {
                if (!ClockProvider().setFinishes(value.round().toInt())) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Laiko pabaigos ipėjimas  prasideda ankščiau nei prasideda laikas, "
                                  "laiko įspėjimas nustatytas kai liks " +
                              ClockProvider().timeFinishes.toString()),
                    ),
                  );
                }
                ;
              }),
        ),
        Text("10"),
      ],
    );
  }
}
