import 'package:flutter/cupertino.dart';

import '../data/models/movie_model.dart';
import '../data/models/movie_model_impl.dart';
import '../data/vos/actor_vo.dart';
import '../data/vos/genre_vo.dart';
import '../data/vos/movie_vo.dart';

class HomeBloc extends ChangeNotifier {
  /// State variables
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<MovieVO>? topRatedMovies;
  List<MovieVO>? moviesByGenres;
  List<GenreVO>? genres;
  List<ActorVO>? actors;

  /// Page
  int pageForNowPlayingMovies = 1;

  /// Model
  MovieModel movieModel = MovieModelImpl();

  HomeBloc([MovieModel? mockMovieModel]) {
    /// Set Mock MovieModel for Test Data
    if (mockMovieModel != null) {
      this.movieModel = mockMovieModel;
    }

    /// Now Playing Movies From Db
    movieModel.getNowPlayingMoviesFromDatabase().listen((list) {
      nowPlayingMovies = list;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Popular Movies From Db
    movieModel.getPopularMoviesFromDatabase().listen((list) {
      popularMovies = list.take(5).toList();
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Genres
    movieModel.getGenres().then((list) {
      this.genres = list;
      notifyListeners();

      getMoviesByGenres(genres?.first.id ?? 0);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Genres From Db
    movieModel.getGenresFromDatabase().then((list) {
      this.genres = list;
      notifyListeners();

      getMoviesByGenres(genres?.first.id ?? 0);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Top Rated Movies From Db
    movieModel.getTopRatedMoviesFromDatabase().listen((list) {
      topRatedMovies = list;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Actors From Db
    movieModel.getActors(1).then((list) {
      actors = list;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Actors From Db
    movieModel.getAllActorsFromDatabase().then((list) {
      actors = list;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void getMoviesByGenres(int genreId) {
    movieModel.getMoviesByGenre(genreId).then((list) {
      moviesByGenres = list.where((item) => item.posterPath != null).toList();
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void onNowPlayingMovieListEndReached() {
    pageForNowPlayingMovies += 1;
    movieModel.getNowPlayingMovies(pageForNowPlayingMovies);
  }
}
