import 'package:flutter/cupertino.dart';

import '../data/models/movie_model.dart';
import '../data/models/movie_model_impl.dart';
import '../data/vos/actor_vo.dart';
import '../data/vos/genre_vo.dart';
import '../data/vos/movie_vo.dart';

class HomeBloc extends ChangeNotifier {
  /// State variables
  List<MovieVO>? getNowPlayingMovies;
  List<MovieVO>? popularMovies;
  List<MovieVO>? topRatedMovies;
  List<MovieVO>? moviesByGenres;
  List<GenreVO>? genres;
  List<ActorVO>? actors;

  /// Model
  MovieModel movieModel = MovieModelImpl();

  HomeBloc() {
    /// Now Playing Movies From Db
    movieModel.getNowPlayingMoviesFromDatabase().listen((list) {
      getNowPlayingMovies = list;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Popular Movies From Db
    movieModel.getNowPlayingMoviesFromDatabase().listen((list) {
      popularMovies = list.sublist(0, list.length ~/ 2.8);
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
}
