import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/retrofit_movie_data_agent_impl.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel {
  MovieDataAgent movieDataAgent = RetrofitMovieDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal() {
    getNowPlayingMoviesFromDatabase();
    getTopRatedMoviesFromDatabase();
    getPopularMoviesFromDatabase();
    getAllActorsFromDatabase();
    getGenresFromDatabase();
    getGenres();
    getActors(1);
  }

  /// Daos
  MovieDao movieDao = MovieDao();
  GenreDao genreDao = GenreDao();
  ActorDao actorDao = ActorDao();

  /// HomePage State Variables
  List<MovieVO>? mNowPlayingMovieList;
  List<MovieVO>? mPopularMovieList;
  List<MovieVO>? mTopRatedMovieList;
  List<MovieVO>? mMoviesByGenreList;
  List<GenreVO>? mGenreList;
  List<ActorVO>? mActors;

  /// MovieDetail State Variables
  MovieVO? mMovie;
  List<ActorVO>? mActorList;
  List<ActorVO>? mCreatorList;

  @override
  void getNowPlayingMovies(int page) {
    movieDataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveAllMovies(nowPlayingMovies);
      mNowPlayingMovieList = nowPlayingMovies;
      notifyListeners();
    });
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    return movieDataAgent.getActors(page).then((actors) async {
      actorDao.saveAllActors(actors);
      mActors = actors;
      notifyListeners();
      return Future.value(actors);
    });
  }

  @override
  Future<List<GenreVO>> getGenres() {
    return movieDataAgent.getGenres().then((genres) async {
      genreDao.saveAllGenres(genres);
      mGenreList = genres;
      getMoviesByGenre(genres.first.id ?? 0);
      notifyListeners();
      return Future.value(genres);
    });
  }

  @override
  void getMoviesByGenre(int genreId) {
    movieDataAgent.getMoviesByGenre(genreId).then((value) {
      mMoviesByGenreList = value;
      notifyListeners();
    });
  }

  @override
  void getPopularMovies(int page) {
    movieDataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = true;
        movie.isTopRated = false;
        return movie;
      }).toList();
      movieDao.saveAllMovies(nowPlayingMovies);
      mPopularMovieList = nowPlayingMovies;
      notifyListeners();
    });
  }

  @override
  void getTopRatedMovies(int page) {
    movieDataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = false;
        movie.isTopRated = true;
        return movie;
      }).toList();
      movieDao.saveAllMovies(nowPlayingMovies);
      mTopRatedMovieList = nowPlayingMovies;
      notifyListeners();
    });
  }

  @override
  void getCreditsByMovie(int movieId) {
    movieDataAgent.getCreditsByMovie(movieId).then((castAndCrew) {
      mActorList = castAndCrew.first;
      mCreatorList = castAndCrew[1];
      notifyListeners();
    });
  }

  @override
  void getMovieDetails(int movieId) {
    movieDataAgent.getMovieDetails(movieId).then((movie) async {
      movieDao.saveSingleMovie(movie);
      mMovie = movie;
      notifyListeners();
    });
  }

  /// Database

  @override
  void getGenresFromDatabase() {
    mGenreList = genreDao.getAllGenre();
    notifyListeners();
  }

  @override
  void getMovieDetailsFromDatabase(int movieId) {
    mMovie = movieDao.getSingleMovie(movieId);
    notifyListeners();
  }

  @override
  void getNowPlayingMoviesFromDatabase() {
    getNowPlayingMovies(1);
    movieDao
        .getAllMoviesEventStream()
        .startWith(movieDao.getNowPlayingMoviesStream())
        .map((event) => movieDao.getNowPlayingMovies())
        .listen((event) {
      mNowPlayingMovieList = event;
      notifyListeners();
    });
  }

  @override
  void getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    movieDao
        .getAllMoviesEventStream()
        .startWith(movieDao.getPopularMoviesStream())
        .map((event) => movieDao.getPopularMoviesMovies())
        .listen((event) {
      mPopularMovieList = event;
      notifyListeners();
    });
  }

  @override
  void getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    movieDao
        .getAllMoviesEventStream()
        .startWith(movieDao.getTopRatedMoviesStream())
        .map((event) => movieDao.getTopRatedMovies())
        .listen((event) {
      mTopRatedMovieList = event;
      notifyListeners();
    });
  }

  @override
  void getAllActorsFromDatabase() {
    mActors = actorDao.getAllActor();
    notifyListeners();
  }
}
