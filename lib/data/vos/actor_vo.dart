import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constants.dart';

import 'movie_vo.dart';

part 'actor_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACTOR_VO, adapterName: "ActorVOAdapter")
class ActorVO {
  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "id")
  @HiveField(1)
  int? id;

  @JsonKey(name: "known_for")
  @HiveField(2)
  List<MovieVO>? knownFor;

  @JsonKey(name: "popularity")
  @HiveField(3)
  double? popularity;

  @JsonKey(name: "name")
  @HiveField(4)
  String? name;

  @JsonKey(name: "profile_path")
  @HiveField(5)
  String? profilePath;

  @JsonKey(name: "known_for_department")
  @HiveField(6)
  String? knownForDepartment;

  @JsonKey(name: "original_name")
  @HiveField(7)
  String? originalName;

  @JsonKey(name: "cast_id")
  @HiveField(8)
  int? castId;

  @JsonKey(name: "character")
  @HiveField(9)
  String? character;

  @JsonKey(name: "credit_id")
  @HiveField(10)
  String? creditId;

  @JsonKey(name: "order")
  @HiveField(11)
  int? order;

  ActorVO(
      this.adult,
      this.id,
      this.knownFor,
      this.popularity,
      this.name,
      this.profilePath,
      this.knownForDepartment,
      this.originalName,
      this.castId,
      this.character,
      this.creditId,
      this.order);

  factory ActorVO.fromJson(Map<String, dynamic> json) =>
      _$ActorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ActorVOToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActorVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
