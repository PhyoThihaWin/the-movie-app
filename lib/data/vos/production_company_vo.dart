import 'package:json_annotation/json_annotation.dart';

part 'production_company_vo.g.dart';

@JsonSerializable()
class ProductionCompanyVO {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "logo_path")
  String? logoPath;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "origin_country")
  String? originalCountry;

  ProductionCompanyVO(this.id, this.logoPath, this.name, this.originalCountry);

  factory ProductionCompanyVO.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyVOToJson(this);
}
