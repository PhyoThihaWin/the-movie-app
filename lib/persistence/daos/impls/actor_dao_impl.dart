import 'package:hive/hive.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/hive_constants.dart';

import '../../../data/vos/actor_vo.dart';

class ActorDaoImpl extends ActorDao{
  ActorDaoImpl._internal();

  static final ActorDaoImpl _singleton = ActorDaoImpl._internal();

  factory ActorDaoImpl() {
    return _singleton;
  }

  Box<ActorVO> getActorBox() {
    return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }

  @override
  void saveAllActors(List<ActorVO> actorList) async {
    Map<int, ActorVO> actorMap = {
      for (var element in actorList) element.id ?? 0: element
    };
    getActorBox().putAll(actorMap);
  }

  @override
  List<ActorVO> getAllActors() {
    return getActorBox().values.toList();
  }
}
