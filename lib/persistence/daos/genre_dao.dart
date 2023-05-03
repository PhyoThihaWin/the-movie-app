import '../../data/vos/genre_vo.dart';

abstract class GenreDao {
  void saveAllGenres(List<GenreVO> genreList);
  List<GenreVO> getAllGenres();
}