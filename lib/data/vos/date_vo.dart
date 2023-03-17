import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constants.dart';

part 'date_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_DATE_VO, adapterName: "DateVOAdapter")
class DateVO {
  @JsonKey(name: "minimum")
  @HiveField(0)
  String? minimum;

  @JsonKey(name: "maximum")
  @HiveField(1)
  String? maximum;

  DateVO(this.minimum, this.maximum);

  factory DateVO.fromJson(Map<String, dynamic> json) =>
      _$DateVOFromJson(json);

  Map<String, dynamic> toJson() => _$DateVOToJson(this);
}
