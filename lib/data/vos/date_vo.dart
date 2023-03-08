import 'package:json_annotation/json_annotation.dart';

part 'date_vo.g.dart';

@JsonSerializable()
class DateVO {
  @JsonKey(name: "minimum")
  String? minimum;

  @JsonKey(name: "maximum")
  String? maximum;

  DateVO(this.minimum, this.maximum);

  factory DateVO.fromJson(Map<String, dynamic> json) =>
      _$DateVOFromJson(json);

  Map<String, dynamic> toJson() => _$DateVOToJson(this);
}
