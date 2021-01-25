// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Animal _$AnimalFromJson(Map<String, dynamic> json) {
  return Animal(
    json['id'] as int,
    json['name'] as String,
    json['nameRu'] as String,
    json['nameEn'] as String,
    json['imagePath'] as String,
    json['description'] as String,
    json['descriptionRu'] as String,
    json['descriptionEn'] as String,
    json['audioPath'] as String,
    json['audioPathRu'] as String,
    json['audioPathEn'] as String,
  );
}

Map<String, dynamic> _$AnimalToJson(Animal instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameRu': instance.nameRu,
      'nameEn': instance.nameEn,
      'imagePath': instance.imagePath,
      'description': instance.description,
      'descriptionRu': instance.descriptionRu,
      'descriptionEn': instance.descriptionEn,
      'audioPath': instance.audioPath,
      'audioPathRu': instance.audioPathRu,
      'audioPathEn': instance.audioPathEn,
    };
