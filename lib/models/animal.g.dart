// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Animal _$AnimalFromJson(Map<String, dynamic> json) {
  return Animal(
    json['id'] as int,
    json['name'] as String,
    json['imagePath'] as String,
    json['description'] as String,
    json['audioPath'] as String,
  );
}

Map<String, dynamic> _$AnimalToJson(Animal instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imagePath': instance.imagePath,
      'description': instance.description,
      'audioPath': instance.audioPath,
    };
