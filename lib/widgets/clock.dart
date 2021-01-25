import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:safari_one/models/clockProvider.dart';

class Clock extends StatelessWidget {
  final ClockGetter clockGetter = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => clockGetter.stop(),
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 25, 0, 0),
        width: MediaQuery.of(context).size.width / 4.5,
        height: MediaQuery.of(context).size.width / 15.625,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: clockGetter.timeAlmostOver == true
              ? Colors.pink
              : Colors.white.withOpacity(.8),
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                offset: Offset(-3, -3),
                color: Colors.white.withOpacity(.05)),
            BoxShadow(
                blurRadius: 3,
                offset: Offset(3, 3),
                color: Colors.black.withOpacity(.25)),
          ],
        ),
        child: Center(
          child: Obx(
            () => Text(
              clockGetter.whatsleft,
              style: TextStyle(
                  color: Color(0xff757575),
                  decoration: TextDecoration.none,
                  fontSize: MediaQuery.of(context).size.width / 25,
                  fontFamily: "nunitor"),
            ),
          ),
        ),
      ),
    );
  }
}
