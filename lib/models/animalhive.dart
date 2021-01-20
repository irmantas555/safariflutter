import 'package:hive/hive.dart';

part 'animalhive.g.dart';

@HiveType(typeId: 0)
class AnimalHive {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String imagePath;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String audioPath;

  AnimalHive(this.name, this.imagePath, this.description, this.audioPath);

  AnimalHive.clone(AnimalHive animalHive)
      : this(animalHive.name, animalHive.imagePath, animalHive.description,
            animalHive.audioPath);

  @override
  String toString() {
    return "Name: $name, ImagePath: $imagePath, Description: $description, AudioPath: $audioPath ";
  }
}
