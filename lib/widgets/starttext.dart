import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/models/locals.dart';

class StartText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextButtonState();
}

class _TextButtonState extends State<StartText> {
  bool ready = false;

  @override
  void initState() {
    dela();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: LocaleGetter.loaded,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          String textValue;
          if (snapshot.hasData) {
            textValue = context.watch<LocaleGetter>().current_list[2];
          } else {
            textValue = "Pradėti";
          }
          return Text(
            textValue,
            style: TextStyle(
                color: NeumorphicTheme.accentColor(context),
                fontSize: MediaQuery.of(context).size.width * .03),
          );
        });
  }

  Future<void> dela() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      ready = true;
    });
  }
}
