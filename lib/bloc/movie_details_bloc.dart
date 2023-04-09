import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../data/models/movie_model.dart';
import '../data/models/movie_model_impl.dart';

class MovieDetailsBloc {
  StreamController<MovieVO?> mMovieStreamController = StreamController();
  StreamController<List<ActorVO>> mActorsStreamController = StreamController();
  StreamController<List<ActorVO>> mCreatorStreamController = StreamController();

  MovieModel mMovieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId) {
    mMovieModel.getMovieDetails(movieId).then((movieDetails) {
      mMovieStreamController.sink.add(movieDetails);
    }).catchError((error) => debugPrint(error.toString()));

    ///  Movie Detail from Db
    mMovieModel.getMovieDetailsFromDatabase(movieId).then((movieDetails) {
      if (movieDetails != null) {
        mMovieStreamController.sink.add(movieDetails);
      }
    }).catchError((error) => debugPrint(error.toString()));

    /// Credits
    mMovieModel.getCreditsByMovie(movieId).then((castAndCrew) {
      mActorsStreamController.sink.add(castAndCrew.first);
      mCreatorStreamController.sink.add(castAndCrew[1]);
    }).catchError((error) => debugPrint(error.toString()));
  }

  void dispose() {
    mMovieStreamController.close();
    mActorsStreamController.close();
    mCreatorStreamController.close();
  }

}
