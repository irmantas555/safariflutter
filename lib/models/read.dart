import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:safari_one/models/animal.dart';

class Read {
  static Future<List<Animal>> readAnimals() async {
    // print("Starting read animals");
    // try {
    //   var animprovider = Provider.of<AnimalsProvider>(context);
    // } catch (er) {
    //   print("Provider error occured");
    // }

    try {
      // Read the file
      String contents =
          await rootBundle.loadString("assets/model_files/animals.json");
      // print("Contents " + contents);

      var animalsJson = jsonDecode(contents)['animals'] as List;
      List<Animal> animals =
          animalsJson.map((anmJson) => Animal.fromJson(anmJson)).toList();
      return animals;
    } catch (e) {
      // If encountering an error, return 0
      // print("Error occoured");
      return null;
    }
  }
}
