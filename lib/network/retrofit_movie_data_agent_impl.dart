import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/the_movie_api.dart';

import '../data/vos/movie_vo.dart';

class RetrofitMovieDataAgentImpl implements MovieDataAgent {
  late TheMovieApi movieApi;

  static final RetrofitMovieDataAgentImpl _singleton =
      RetrofitMovieDataAgentImpl._internal();

  factory RetrofitMovieDataAgentImpl() {
    return _singleton;
  }

  RetrofitMovieDataAgentImpl._internal() {
    final dio = Dio();
    movieApi = TheMovieApi(dio);
  }

  @override
  Future<List<MovieVO>> getNowPlayingMovies(int page) {
    return movieApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_ENUS, page)
        .asStream()
        .map((response) => response.results ?? [])
        .first;
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    return movieApi
        .getActors(API_KEY, LANGUAGE_ENUS, page)
        .asStream()
        .map((response) => response.results ?? [])
        .first;
  }

  @override
  Future<List<GenreVO>> getGenres() {
    return movieApi
        .getGenres(API_KEY, LANGUAGE_ENUS)
        .asStream()
        .map((response) => response.genres ?? [])
        .first;
  }

  @override
  Future<List<MovieVO>> getMoviesByGenre(int genreId) {
    return movieApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_ENUS, genreId)
        .asStream()
        .map((response) => response.results ?? [])
        .first;
  }

  @override
  Future<List<MovieVO>> getPopularMovies(int page) {
    return movieApi
        .getPopularMovies(API_KEY, LANGUAGE_ENUS, page)
        .asStream()
        .map((response) => response.results ?? [])
        .first;
  }

  @override
  Future<List<MovieVO>> getTopRatedMovies(int page) {
    return movieApi
        .getTopRatedMovies(API_KEY, LANGUAGE_ENUS, page)
        .asStream()
        .map((response) => response.results ?? [])
        .first;
  }
}
