import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
class LocaleProvider{
  // static final animalbox = () async => await Hive.openBox('animals');
  static final List<String> _lt_list = [];
  static final List<String> _ru_list = [];
  static final List<String> _en_list = [];

  LocaleProvider() {
    readAnimalsHive();
  }


  static Future<void> readAnimalsHive() async {
    // print("Starting read animals");
    var hive;
    try {
      // Read the file
      String contents =
          await rootBundle.loadString("assets/model_files/local.json");
      // print("Contents " + contents);

      Map<String, dynamic> ltMap = jsonDecode(contents)['text_lt'];
      List<String> ltString = new List<String>.from(ltMap['value']);

      Map<String, dynamic> ruMap = jsonDecode(contents)['text_lt'];
      List<String> ruString = new List<String>.from(ltMap['value']);

      Map<String, dynamic> enMap = jsonDecode(contents)['text_lt'];
      List<String> enString = new List<String>.from(ltMap['value']);

      if (ltString.length > 0) {
        _lt_list.addAll(ltString);
      }

      if (ruString.length > 0) {
        _ru_list.addAll(ltString);
      }

      if (enString.length > 0) {
        _en_list.addAll(ltString);
      }

    } catch (e) {
      // If encountering an error, return 0
      print("Error occoured");
      return null;
    }
  }

}
