import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/genre_vo.dart';

import 'package:movie_app/data/vos/genre_vo.dart';

import 'package:movie_app/data/vos/genre_vo.dart';

import 'package:movie_app/data/vos/genre_vo.dart';

import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

class GenreDao {
  GenreDao._internal();

  static final GenreDao _singleton = GenreDao._internal();

  factory GenreDao() {
    return _singleton;
  }


  Box<GenreVO> getGenreBox() {
    return Hive.box<GenreVO>(BOX_NAME_GENRE_VO);
  }

  void saveAllGenres(List<GenreVO> genreList) async {
    Map<int, GenreVO> genreMap = {
      for (var element in genreList) element.id ?? 0: element
    };
    getGenreBox().putAll(genreMap);
  }

  List<GenreVO> getAllGenre() {
    return getGenreBox().values.toList();
  }

}
