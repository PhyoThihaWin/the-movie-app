// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_country_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductionCountryVOAdapter extends TypeAdapter<ProductionCountryVO> {
  @override
  final int typeId = 8;

  @override
  ProductionCountryVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductionCountryVO(
      fields[0] as String?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductionCountryVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.iso31661)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductionCountryVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionCountryVO _$ProductionCountryVOFromJson(Map<String, dynamic> json) =>
    ProductionCountryVO(
      json['iso_3166_1'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$ProductionCountryVOToJson(
        ProductionCountryVO instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso31661,
      'name': instance.name,
    };
