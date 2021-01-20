import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import 'package:safari_one/models/animal.dart';
import 'package:safari_one/models/animalhive.dart';

class AnimalsProvider extends ChangeNotifier {
  // static final animalbox = () async => await Hive.openBox('animals');
  static final List<AnimalHive> _animallist = [];
  static Box animalbox;
  AnimalHive activeAnimal;
  int activeAnimalIndex;

  AnimalsProvider() {
    inint();
  }

  UnmodifiableListView<AnimalHive> get animalList =>
      UnmodifiableListView(_animallist);

  Future<void> inint() async {
    animalbox = await Hive.openBox('animals');
    if (animalbox.isEmpty) {
      await readAnimalsHive();
    } else {
      for (int i = 0; i < animalbox.length; i++) {
        _animallist.add(animalbox.getAt(i) as AnimalHive);
      }
    }
    return;
  }

  void addAll(Iterable<AnimalHive> animalist) {
    _animallist.addAll(_animallist);
    animalbox.addAll(animalist);
    notifyListeners();
  }

  void setCurrent(int index) {
    if (_animallist.length > 0) {
      activeAnimalIndex = index;
      activeAnimal = _animallist[index];
    }
    notifyListeners();
  }

  void next() {
    if (animalbox.length > 0) {
      if (animalbox.length > activeAnimalIndex + 1) {
        activeAnimalIndex = activeAnimalIndex + 1;
        activeAnimal = _animallist[activeAnimalIndex];
      }
    }
    notifyListeners();
  }

  void previous() {
    if (activeAnimalIndex - 1 > 0) {
      activeAnimalIndex = activeAnimalIndex - 1;
      activeAnimal = _animallist[activeAnimalIndex];
    }
    notifyListeners();
  }

  int add(AnimalHive animal) {
    _animallist.add(animal);
    animalbox.add(animal);
    notifyListeners();
    return _animallist.length - 1;
  }

  // void moveUp(int index) {
  //   if (index > 0) {
  //     Animal first = animalbox.getAt(index - 1);
  //     Animal second = animalbox.getAt(index);
  //     _animalsList[index] = first;
  //     _animalsList[index - 1] = second;
  //     notifyListeners();
  //   }
  // }
  //
  // void moveDown(int index) {
  //   if (index < _animalsList.length - 1) {
  //     Animal first = _animalsList[index];
  //     Animal second = _animalsList[index + 1];
  //     _animalsList[index] = second;
  //     _animalsList[index + 1] = first;
  //     notifyListeners();
  //   }
  // }

  void remove(int index) {
    _animallist.removeAt(index);
    animalbox.deleteAt(index);
    notifyListeners();
  }

  void update(AnimalHive animalHive, int index) {
    _animallist[index] = animalHive;
    animalbox.put(animalbox.keyAt(index), animalHive);
    notifyListeners();
  }

  static Future<List<Animal>> readAnimals() async {
    // print("Starting read animals");

    try {
      // Read the file
      String contents =
          await rootBundle.loadString("assets/model_files/animals.json");
      // print("Contents " + contents);

      var animalsJson = jsonDecode(contents)['animals'] as List;
      List<Animal> animals =
          animalsJson.map((anmJson) => Animal.fromJson(anmJson)).toList();
      animals.forEach((element) {
        // print(element.name);
      });
      if (animals.length > 0) {}
      return animals;
    } catch (e) {
      // If encountering an error, return 0
      print("Error occoured");
      return null;
    }
  }

  static Future<void> readAnimalsHive() async {
    // print("Starting read animals");
    var hive;
    try {
      // Read the file
      String contents =
          await rootBundle.loadString("assets/model_files/animals.json");
      // print("Contents " + contents);

      var animalsJson = jsonDecode(contents)['animals'] as List;
      List<Animal> animals =
          animalsJson.map((anmJson) => Animal.fromJson(anmJson)).toList();
      animals.forEach((element) {
        // print(element.name);
      });
      if (animals.length > 0) {}
      for (int i = 0; i < animals.length; i++) {
        hive = AnimalHive(animals[i].name, animals[i].imagePath,
            animals[i].description, animals[i].audioPath);
        _animallist.add(hive);
        animalbox.add(hive);
      }
    } catch (e) {
      // If encountering an error, return 0
      print("Error occoured");
      return null;
    }
  }

  void importanimals() async {
    await inint();
    // await Hive.deleteBoxFromDisk("animals");
    // for (int k = 0; k < animalboxtwo.length; k++) {
    //   animalboxtwo.delete(animalboxtwo.getAt(k));
    // }
    // for (int i = 0; i < _animalsList.length; i++) {
    //   animalboxtwo.add(AnimalHive(
    //       _animalsList[i].name,
    //       _animalsList[i].imagePath,
    //       _animalsList[i].description,
    //       _animalsList[i].audioPath));
    // }
    print("box length" + animalbox.length.toString());
    // animalboxtwo.close();
  }

  persist() {
    Hive.box('animals');
  }
}
