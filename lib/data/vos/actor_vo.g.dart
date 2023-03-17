// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActorVOAdapter extends TypeAdapter<ActorVO> {
  @override
  final int typeId = 1;

  @override
  ActorVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActorVO(
      fields[0] as bool?,
      fields[1] as int?,
      (fields[2] as List?)?.cast<MovieVO>(),
      fields[3] as double?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as String?,
      fields[7] as String?,
      fields[8] as int?,
      fields[9] as String?,
      fields[10] as String?,
      fields[11] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ActorVO obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.adult)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.knownFor)
      ..writeByte(3)
      ..write(obj.popularity)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.profilePath)
      ..writeByte(6)
      ..write(obj.knownForDepartment)
      ..writeByte(7)
      ..write(obj.originalName)
      ..writeByte(8)
      ..write(obj.castId)
      ..writeByte(9)
      ..write(obj.character)
      ..writeByte(10)
      ..write(obj.creditId)
      ..writeByte(11)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActorVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorVO _$ActorVOFromJson(Map<String, dynamic> json) => ActorVO(
      json['adult'] as bool?,
      json['id'] as int?,
      (json['known_for'] as List<dynamic>?)
          ?.map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['popularity'] as num?)?.toDouble(),
      json['name'] as String?,
      json['profile_path'] as String?,
      json['known_for_department'] as String?,
      json['original_name'] as String?,
      json['cast_id'] as int?,
      json['character'] as String?,
      json['credit_id'] as String?,
      json['order'] as int?,
    );

Map<String, dynamic> _$ActorVOToJson(ActorVO instance) => <String, dynamic>{
      'adult': instance.adult,
      'id': instance.id,
      'known_for': instance.knownFor,
      'popularity': instance.popularity,
      'name': instance.name,
      'profile_path': instance.profilePath,
      'known_for_department': instance.knownForDepartment,
      'original_name': instance.originalName,
      'cast_id': instance.castId,
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
    };
