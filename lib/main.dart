import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/network/retrofit_movie_data_agent_impl.dart';
import 'package:movie_app/persistence/hive_constants.dart';

import 'data/vos/collection_vo.dart';
import 'data/vos/date_vo.dart';
import 'data/vos/genre_vo.dart';
import 'data/vos/movie_vo.dart';
import 'data/vos/production_company_vo.dart';
import 'data/vos/production_country_vo.dart';
import 'data/vos/spoken_language_vo.dart';
import 'pages/home_page.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());

  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
