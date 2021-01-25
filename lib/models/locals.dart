import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class LocaleGetter extends GetxController {
  // static final animalbox = () async => await Hive.openBox('animals');
  static var _lt_list = <String>[].obs;
  static var _ru_list = <String>[].obs;
  static var _en_list = <String>[].obs;
  static var _current_list = <String>[].obs;
  static RxString currentLocale = "lt".obs;
  static Future<int> loaded =
      Future.delayed(Duration(seconds: 2)).then((value) => 1);
  static bool finished;

  LocaleGetter() {
    _current_list.add("Pradėti");
    readLocales();
  }

  get current_list => _current_list;

  Future<void> changeLocaleList(String locale) async {
    if (locale != currentLocale) {
      switch (locale) {
        case "lt":
          current_list.setAll(0, _lt_list);
          currentLocale(locale);
          break;
        case "ru":
          current_list.setAll(0, _ru_list);
          currentLocale(locale);
          break;
        case "en":
          current_list.setAll(0, _en_list);
          currentLocale(locale);
          break;
      }
    }
  }

  changeItems(List<String> list) {
    for (int i = 0; i < _current_list.length; i++) {
      _current_list[i] = list[i];
    }
  }

  Future<void> readLocales() async {
    try {
      // Read the file
      String contents =
          await rootBundle.loadString("assets/model_files/local.json");

      Map<String, dynamic> ltMap = jsonDecode(contents)['text_lt'];
      List<String> ltString = new List<String>.from(ltMap['value']);

      Map<String, dynamic> ruMap = jsonDecode(contents)['text_ru'];
      List<String> ruString = new List<String>.from(ruMap['value']);

      Map<String, dynamic> enMap = jsonDecode(contents)['text_en'];
      List<String> enString = new List<String>.from(enMap['value']);

      if (ltString.length > 0) {
        // if (null != _current_list) {
        //   if (_current_list.length > 0) {
        //     _current_list.removeAt(0);
        //   }
        // }
        _lt_list.addAll(ltString);
        _current_list.addAll(ltString);
      }
      if (ruString.length > 0) {
        _ru_list.addAll(ruString);
      }

      if (enString.length > 0) {
        _en_list.addAll(enString);
      }
    } catch (e, stacktrace) {
      // If encountering an error, return 0
      // print("Error occoured" + e);
      return null;
    }
    finished = true;
    return true;
  }
}
