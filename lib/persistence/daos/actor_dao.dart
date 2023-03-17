import 'package:hive/hive.dart';
import 'package:movie_app/persistence/hive_constants.dart';

import '../../data/vos/actor_vo.dart';

class ActorDao {
  ActorDao._internal();

  static final ActorDao _singleton = ActorDao._internal();

  factory ActorDao() {
    return _singleton;
  }

  Box<ActorVO> getActorBox() {
    return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }

  void saveAllActors(List<ActorVO> actorList) async {
    Map<int, ActorVO> actorMap = {
      for (var element in actorList) element.id ?? 0: element
    };
    getActorBox().putAll(actorMap);
  }

  List<ActorVO> getAllActor() {
    return getActorBox().values.toList();
  }
}
