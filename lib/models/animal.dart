import 'package:json_annotation/json_annotation.dart';

part 'animal.g.dart';

@JsonSerializable()
class Animal {
  final int id;
  final String name;
  final String nameRu;
  final String nameEn;
  final String imagePath;
  final String description;
  final String descriptionRu;
  final String descriptionEn;
  final String audioPath;
  final String audioPathRu;
  final String audioPathEn;

  Animal(
      this.id,
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

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);
  Map<String, dynamic> toJson() => _$AnimalToJson(this);
}
