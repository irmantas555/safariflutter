// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animalhive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalHiveAdapter extends TypeAdapter<AnimalHive> {
  @override
  final int typeId = 0;

  @override
  AnimalHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnimalHive(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
      fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AnimalHive obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.nameRu)
      ..writeByte(2)
      ..write(obj.nameEn)
      ..writeByte(3)
      ..write(obj.imagePath)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.descriptionRu)
      ..writeByte(6)
      ..write(obj.descriptionEn)
      ..writeByte(7)
      ..write(obj.audioPath)
      ..writeByte(8)
      ..write(obj.audioPathRu)
      ..writeByte(9)
      ..write(obj.audioPathEn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
