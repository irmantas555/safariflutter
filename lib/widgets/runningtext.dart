import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter/cupertino.dart';

class RunningText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Run_Text_State();
}

class _Run_Text_State extends State<RunningText> {
  @override
  Widget build(BuildContext context) {
    return "Pairinkite gyvūną žemiau kad sužinotute daugiau"
        .marquee(
          textStyle: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.none,
              color: Colors.white10.withOpacity(.7)),
        )
        .h4(context);
  }
}
