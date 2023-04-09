import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../data/models/movie_model.dart';

class HomeBloc {
  /// Reactive Streams
  StreamController<List<MovieVO>> mNowPlayingMovieListStreamController = StreamController();
  StreamController<List<MovieVO>?> mPopularMovieListStreamController = StreamController();
  StreamController<List<GenreVO>> mGenreListStreamController = StreamController();
  StreamController<List<ActorVO>> mActorsStreamController = StreamController();
  StreamController<List<MovieVO>> mTopRatedMovieListStreamController = StreamController();
  StreamController<List<MovieVO>> mMovieByGenreListStreamController = StreamController();

  // Models
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc() {
    /// Now Playing Movies From Db
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((list) {
      mNowPlayingMovieListStreamController.sink.add(list);
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Popular Movies From Db
    mMovieModel.getPopularMoviesFromDatabase().listen((list) {
      mPopularMovieListStreamController.sink.add(list?.take(8).toList());
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Genres
    mMovieModel.getGenres().then((list) {
      mGenreListStreamController.sink.add(list);
      getMoviesByGenres(list.first.id ?? 0);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Genres From Db
    mMovieModel.getGenresFromDatabase().then((list) {
      mGenreListStreamController.sink.add(list);
      getMoviesByGenres(list.first.id ?? 0);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Top Rated Movies From Db
    mMovieModel.getTopRatedMoviesFromDatabase().listen((list) {
      mTopRatedMovieListStreamController.sink.add(list);
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Actors From Db
    mMovieModel.getActors(1).then((list) {
      mActorsStreamController.sink.add(list);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Actors From Db
    mMovieModel.getAllActorsFromDatabase().then((list) {
      mActorsStreamController.sink.add(list);
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void getMoviesByGenres(int genreId) {
    mMovieModel.getMoviesByGenre(genreId).then((list) {
      mMovieByGenreListStreamController.sink
          .add(list.where((item) => item.posterPath != null).toList());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void dispose() {
    mNowPlayingMovieListStreamController.close();
    mPopularMovieListStreamController.close();
    mGenreListStreamController.close();
    mActorsStreamController.close();
    mTopRatedMovieListStreamController.close();
    mMovieByGenreListStreamController.close();
  }
}
