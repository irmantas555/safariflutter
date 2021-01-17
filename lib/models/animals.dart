import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:safari_one/models/animal.dart';

class AnimalsProvider extends ChangeNotifier {
  static final List<Animal> _animalsList = [];
  Animal activeAnimal;
  int activeAnimalIndex;

  AnimalsProvider() {
    readAnimals().then((value) => postProcess(value)).then((value) => {
          activeAnimalIndex = 0,
          activeAnimal = _animalsList[0],
        });
  }

  void postProcess(List<Animal> animals) {
    _animalsList.addAll(animals);
    // print("So much animals: " + _animalsList.length.toString());
    notifyListeners();
    // print("Privider initialized");
  }

  UnmodifiableListView<Animal> get animalList =>
      UnmodifiableListView(_animalsList);

  void addAll(Iterable<Animal> animalist) {
    _animalsList.addAll(animalist);
  }

  void setCurrent(int index) {
    if (_animalsList.length > 0) {
      activeAnimalIndex = index;
      activeAnimal = _animalsList[index];
    }
  }

  void next() {
    if (_animalsList.length > 0) {
      if (_animalsList.length > activeAnimalIndex + 1) {
        activeAnimalIndex = activeAnimalIndex + 1;
        activeAnimal = _animalsList[activeAnimalIndex];
      }
    }
  }

  void previous() {
    if (activeAnimalIndex - 1 > 0) {
      activeAnimalIndex = activeAnimalIndex - 1;
      activeAnimal = _animalsList[activeAnimalIndex];
    }
  }

  void add(Animal animal) {
    _animalsList.add(animal);
    notifyListeners();
  }

  void remove(int id) {
    _animalsList.forEach((element) {
      if (element.id == id) {
        _animalsList.remove(element);
      }
    });
    notifyListeners();
  }

  void update(Animal animal) {
    var index = 0;
    _animalsList.forEach((element) {
      if (element.id == animal.id) {
        _animalsList[index] = animal;
      }
    });
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
}
