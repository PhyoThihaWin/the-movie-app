import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/retrofit_movie_data_agent_impl.dart';

class MovieModelImpl extends MovieModel {
  MovieDataAgent movieDataAgent = RetrofitMovieDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  @override
  Future<List<MovieVO>> getNowPlayingMovies(int page) {
    return movieDataAgent.getNowPlayingMovies(page);
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    return movieDataAgent.getActors(page);
  }

  @override
  Future<List<GenreVO>> getGenres() {
    return movieDataAgent.getGenres();
  }

  @override
  Future<List<MovieVO>> getMoviesByGenre(int genreId) {
    return movieDataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<MovieVO>> getPopularMovies(int page) {
    return movieDataAgent.getPopularMovies(page);
  }

  @override
  Future<List<MovieVO>> getTopRatedMovies(int page) {
    return movieDataAgent.getTopRatedMovies(page);
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return movieDataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return movieDataAgent.getMovieDetails(movieId);
  }

}
