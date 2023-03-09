import 'package:movie_app/data/vos/movie_vo.dart';

import '../vos/actor_vo.dart';
import '../vos/genre_vo.dart';

abstract class MovieModel {
  Future<List<MovieVO>> getNowPlayingMovies(int page);

  Future<List<MovieVO>> getPopularMovies(int page);

  Future<List<MovieVO>> getTopRatedMovies(int page);

  Future<List<GenreVO>> getGenres();

  Future<List<MovieVO>> getMoviesByGenre(int genreId);

  Future<List<ActorVO>> getActors(int page);

  Future<MovieVO?> getMovieDetails(int movieId);

  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);
}
