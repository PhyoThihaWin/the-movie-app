import 'package:flutter/cupertino.dart';

import '../data/models/movie_model.dart';
import '../data/models/movie_model_impl.dart';
import '../data/vos/actor_vo.dart';
import '../data/vos/movie_vo.dart';

class MovieDetailsBloc extends ChangeNotifier {
  /// State Variables
  MovieVO? movieDetails;
  List<ActorVO>? cast;
  List<ActorVO>? crew;
  List<MovieVO>? relatedMovies;

  /// Model
  final MovieModel _movieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId) {
    /// Movie Detail
    _movieModel.getMovieDetails(movieId).then((movieDetails) {
      this.movieDetails = movieDetails;
      getRelatedMovies(movieDetails?.genres?.first.id ?? 0);
      notifyListeners();
    }).catchError((error) => debugPrint(error.toString()));

    ///  Movie Detail from Db
    _movieModel.getMovieDetailsFromDatabase(movieId).then((movieDetails) {
      if (movieDetails != null) {
        this.movieDetails = movieDetails;
        notifyListeners();
      }
    }).catchError((error) => debugPrint(error.toString()));

    /// Credits
    _movieModel.getCreditsByMovie(movieId).then((castAndCrew) {
      cast = castAndCrew.first;
      crew = castAndCrew[1];
      notifyListeners();
    }).catchError((error) => debugPrint(error.toString()));
  }

  void getRelatedMovies(int genreId) {
    _movieModel
        .getMoviesByGenre(genreId)
        .then((value) => relatedMovies = value);
    notifyListeners();
  }
}
