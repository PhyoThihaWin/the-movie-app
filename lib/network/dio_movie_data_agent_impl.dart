import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/movie_data_agent.dart';

import 'api_constants.dart';

class DioMovieDataAgentImpl implements MovieDataAgent {
  @override
  Future<List<MovieVO>> getNowPlayingMovies(int page) {
    Map<String, String> queryParameters = {
      PARAM_API_KEY: API_KEY,
      PARAM_LANGUAGE: LANGUAGE_ENUS,
      PARAM_PAGE: page.toString()
    };

    Dio()
        .get(BASE_URL_DIO + ENDPOINT_GET_NOW_PLAYING,
            queryParameters: queryParameters)
        .then((value) {
      debugPrint("Now playing movie => ${value.toString()}");
    }).catchError((error) {
      debugPrint("Error ===> ${error.toString()}");
    });

    return Future(() => List<MovieVO>.empty());
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    // TODO: implement getActors
    throw UnimplementedError();
  }

  @override
  Future<List<GenreVO>> getGenres() {
    // TODO: implement getGenres
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>> getMoviesByGenre(int genreId) {
    // TODO: implement getMoviesByGenre
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>> getPopularMovies(int page) {
    // TODO: implement getPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>> getTopRatedMovies(int page) {
    // TODO: implement getTopRatedMovies
    throw UnimplementedError();
  }
}