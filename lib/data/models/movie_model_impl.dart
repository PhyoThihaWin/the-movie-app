import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/retrofit_movie_data_agent_impl.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';

class MovieModelImpl extends MovieModel {
  MovieDataAgent movieDataAgent = RetrofitMovieDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  /// Daos
  MovieDao movieDao = MovieDao();
  GenreDao genreDao = GenreDao();
  ActorDao actorDao = ActorDao();

  @override
  Future<List<MovieVO>> getNowPlayingMovies(int page) {
    return movieDataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveAllMovies(nowPlayingMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    return movieDataAgent.getActors(page).then((actors) async {
      actorDao.saveAllActors(actors);
      return Future.value(actors);
    });
  }

  @override
  Future<List<GenreVO>> getGenres() {
    return movieDataAgent.getGenres().then((genres) async {
      genreDao.saveAllGenres(genres);
      return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>> getMoviesByGenre(int genreId) {
    return movieDataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<MovieVO>> getPopularMovies(int page) {
    return movieDataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = true;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveAllMovies(nowPlayingMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>> getTopRatedMovies(int page) {
    return movieDataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = false;
        movie.isTopRated = true;
        return movie;
      }).toList();
      movieDao.saveAllMovies(nowPlayingMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<List<ActorVO>>> getCreditsByMovie(int movieId) {
    return movieDataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return movieDataAgent.getMovieDetails(movieId).then((movie) async {
      movieDao.saveSingleMovie(movie);
      return Future.value(movie);
    });
  }

  /// Database

  @override
  Future<List<GenreVO>> getGenresFromDatabase() {
    return Future.value(genreDao.getAllGenre());
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(movieDao.getSingleMovie(movieId));
  }

  @override
  Future<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    return Future.value(
      movieDao
          .getAllMovie()
          .where((element) => element.isNowPlaying ?? true)
          .toList(),
    );
  }

  @override
  Future<List<MovieVO>> getPopularMoviesFromDatabase() {
    return Future.value(
      movieDao
          .getAllMovie()
          .where((element) => element.isPopular ?? true)
          .toList(),
    );
  }

  @override
  Future<List<MovieVO>> getTopRatedMoviesFromDatabase() {
    return Future.value(
      movieDao
          .getAllMovie()
          .where((element) => element.isTopRated ?? true)
          .toList(),
    );
  }

  @override
  Future<List<ActorVO>> getAllActorsFromDatabase() {
    return Future.value(actorDao.getAllActor());
  }
}
