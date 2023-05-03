import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:movie_app/persistence/hive_constants.dart';

class GenreDaoImpl extends GenreDao{
  GenreDaoImpl._internal();

  static final GenreDaoImpl _singleton = GenreDaoImpl._internal();

  factory GenreDaoImpl() {
    return _singleton;
  }


  Box<GenreVO> getGenreBox() {
    return Hive.box<GenreVO>(BOX_NAME_GENRE_VO);
  }

  @override
  void saveAllGenres(List<GenreVO> genreList) async {
    Map<int, GenreVO> genreMap = {
      for (var element in genreList) element.id ?? 0: element
    };
    getGenreBox().putAll(genreMap);
  }

  @override
  List<GenreVO> getAllGenres() {
    return getGenreBox().values.toList();
  }

}
