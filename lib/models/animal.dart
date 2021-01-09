import 'package:json_annotation/json_annotation.dart';

part 'animal.g.dart';

@JsonSerializable()
class Animal {
  final int id;
  final String name;
  final String imagePath;
  final String description;
  final String audioPath;

  Animal(this.id, this.name, this.imagePath, this.description, this.audioPath);

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);
  Map<String, dynamic> toJson() => _$AnimalToJson(this);
}
