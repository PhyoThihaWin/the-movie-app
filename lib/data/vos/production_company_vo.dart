import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constants.dart';

part 'production_company_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PRODUCTION_COMPANY_VO, adapterName: "ProductionCompanyVOAdapter")
class ProductionCompanyVO {

  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "logo_path")
  @HiveField(1)
  String? logoPath;

  @JsonKey(name: "name")
  @HiveField(2)
  String? name;

  @JsonKey(name: "origin_country")
  @HiveField(3)
  String? originalCountry;

  ProductionCompanyVO(this.id, this.logoPath, this.name, this.originalCountry);

  factory ProductionCompanyVO.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyVOToJson(this);
}
