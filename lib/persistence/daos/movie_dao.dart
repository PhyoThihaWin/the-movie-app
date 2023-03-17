import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

class MovieDao {
  MovieDao._internal();

  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }

  void saveAllMovies(List<MovieVO> movieList) async {
    Map<int, MovieVO> movieMap = {
      for (var element in movieList) element.id ?? 0: element
    };
    getMovieBox().putAll(movieMap);
  }

  List<MovieVO> getAllMovie() {
    return getMovieBox().values.toList();
  }

  void saveSingleMovie(MovieVO movie) async {
    getMovieBox().put(movie.id, movie);
  }

  MovieVO? getSingleMovie(int movieId) {
    return getMovieBox().get(movieId);
  }
}
