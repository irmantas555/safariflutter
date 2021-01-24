import 'package:hive/hive.dart';

part 'animalhive.g.dart';

@HiveType(typeId: 0)
class AnimalHive {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String nameRu;
  @HiveField(2)
  final String nameEn;
  @HiveField(3)
  final String imagePath;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final String descriptionRu;
  @HiveField(6)
  final String descriptionEn;
  @HiveField(7)
  final String audioPath;
  @HiveField(8)
  final String audioPathRu;
  @HiveField(9)
  final String audioPathEn;

  AnimalHive(
      this.name,
      this.nameRu,
      this.nameEn,
      this.imagePath,
      this.description,
      this.descriptionRu,
      this.descriptionEn,
      this.audioPath,
      this.audioPathRu,
      this.audioPathEn);

  AnimalHive.clone(AnimalHive animalHive)
      : this(
            animalHive.name,
            animalHive.nameRu,
            animalHive.nameEn,
            animalHive.imagePath,
            animalHive.description,
            animalHive.descriptionRu,
            animalHive.descriptionEn,
            animalHive.audioPath,
            animalHive.audioPathRu,
            animalHive.audioPathEn);

  @override
  String toString() {
    return "NameLt: $name, NameRu: $nameRu, NameEn: $nameEn, ImagePath: $imagePath,"
        " DescriptionLt: $description, DescriptionRu: $descriptionRu, DescriptionEn: $descriptionEn, AudioPath: $audioPath ";
  }
}
