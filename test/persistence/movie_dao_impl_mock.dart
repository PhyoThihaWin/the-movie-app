import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';

import '../mock_data/mock_data.dart';

class MovieDaoImplMock extends MovieDao {
  Map<int, MovieVO> movieListFromDatabaseMock = {};

  @override
  List<MovieVO> getAllMovies() {
    return getMockMoviesForTest();
  }

  @override
  Stream<void> getAllMoviesEventStream() {
    return Stream<void>.value(null);
  }

  @override
  MovieVO? getMovieById(int movieId) {
    return movieListFromDatabaseMock.values
        .toList()
        .firstWhere((element) => element.id == movieId);
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    if (getMockMoviesForTest().isNotEmpty) {
      return getMockMoviesForTest()
          .where((element) => element.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  List<MovieVO> getPopularMovies() {
    if (getMockMoviesForTest().isNotEmpty) {
      return getMockMoviesForTest()
          .where((element) => element.isPopular ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isPopular ?? false)
        .toList());
  }

  @override
  List<MovieVO> getTopRatedMovies() {
    if (getMockMoviesForTest().isNotEmpty) {
      return getMockMoviesForTest()
          .where((element) => element.isTopRated ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesStream() {
    return Stream.value(getMockMoviesForTest()
        .where((element) => element.isTopRated ?? false)
        .toList());
  }

  @override
  void saveAllMovies(List<MovieVO> movies) {
    for (var movie in movies) {
      movieListFromDatabaseMock[movie.id ?? 0] = movie;
    }
  }

  @override
  void saveSingleMovie(MovieVO movie) {
    movieListFromDatabaseMock[movie.id ?? 0] = movie;
  }
}
