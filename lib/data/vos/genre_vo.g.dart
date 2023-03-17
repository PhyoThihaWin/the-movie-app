// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenreVOAdapter extends TypeAdapter<GenreVO> {
  @override
  final int typeId = 5;

  @override
  GenreVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GenreVO(
      fields[0] as int?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GenreVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenreVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreVO _$GenreVOFromJson(Map<String, dynamic> json) => GenreVO(
      json['id'] as int?,
      json['name'] as String?,
    );

Map<String, dynamic> _$GenreVOToJson(GenreVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
