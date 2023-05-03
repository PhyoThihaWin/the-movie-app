import '../../data/vos/movie_vo.dart';

abstract class MovieDao {
  void saveAllMovies(List<MovieVO> movies);
  void saveSingleMovie(MovieVO movie);
  MovieVO? getMovieById(int movieId);
  List<MovieVO> getAllMovies();
  Stream<void> getAllMoviesEventStream();
  Stream<List<MovieVO>> getNowPlayingMoviesStream();
  Stream<List<MovieVO>> getPopularMoviesStream();
  Stream<List<MovieVO>> getTopRatedMoviesStream();
  List<MovieVO> getNowPlayingMovies();
  List<MovieVO> getPopularMovies();
  List<MovieVO> getTopRatedMovies();
}