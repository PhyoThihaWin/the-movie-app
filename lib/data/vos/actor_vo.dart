import 'package:json_annotation/json_annotation.dart';

import 'movie_vo.dart';

part 'actor_vo.g.dart';

@JsonSerializable()
class ActorVO {
  @JsonKey(name: "adult")
  bool? adult;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "known_for")
  List<MovieVO>? knownFor;

  @JsonKey(name: "popularity")
  double? popularity;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "profile_path")
  String? profilePath;

  ActorVO(this.adult, this.id, this.knownFor, this.popularity, this.name,
      this.profilePath);

  factory ActorVO.fromJson(Map<String, dynamic> json) =>
      _$ActorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ActorVOToJson(this);
}
