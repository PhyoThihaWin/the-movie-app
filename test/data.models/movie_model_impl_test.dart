import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../mock_data/mock_data.dart';
import '../network/movie_data_agent_impl_mock.dart';
import '../persistence/actor_dao_impl_mock.dart';
import '../persistence/genre_dao_impl_mock.dart';
import '../persistence/movie_dao_impl_mock.dart';

void main() {
  group("movie_model_impl", () {
    var movieModel = MovieModelImpl();

    setUp(() {
      movieModel.setDaosAndDataAgents(
        MovieDaoImplMock(),
        ActorDaoImplMock(),
        GenreDaoImplMock(),
        MovieDataAgentImplMock(),
      );
    });

    test("Saving NowPlaying Movies and Getting NowPlaying Movies from Database",
        () {
      expect(
          movieModel.getNowPlayingMoviesFromDatabase(),
          emits([
            MovieVO(
                false,
                "/kCEXA22ASuq7Y29jnngyaisyA0X.jpg",
                [878, 9648, 12],
                62,
                "en",
                "2001: A Space Odyssey",
                "Humanity finds a mysterious object buried beneath the lunar surface and sets off to find its origins with the help of HAL 9000, the world's most advanced super computer.",
                37.981,
                "/ve72VxNqjGM69Uky4WTo2bK6rfq.jpg",
                "1968-04-02",
                "2001: A Space Odyssey",
                false,
                8.1,
                10149,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                true,
                false,
                false),
          ]));
    });

    test("Saving Popular Movies and Getting Popular Movies from Database", () {
      expect(
          movieModel.getPopularMoviesFromDatabase(),
          emits([
            MovieVO(
                false,
                "/AmR3JG1VQVxU8TfAvljUhfSFUOx.jpg",
                [27, 878],
                348,
                "en",
                "Alien",
                "During its return to the earth, commercial spaceship Nostromo intercepts a distress signal from a distant planet. When a three-member team of the crew discovers a chamber containing thousands of eggs on the planet, a creature inside one of the eggs attacks an explorer. The entire crew is unaware of the impending nightmare set to descend upon them when the alien parasite planted inside its unfortunate host is birthed.",
                66.597,
                "/vfrQk5IPloGg1v9Rzbh2Eg3VGyM.jpg",
                "1979-05-25",
                "Alien",
                false,
                8.1,
                12697,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                false,
                true,
                false),
          ]));
    });

    test("Saving TopRated Movies and Getting TopRated Movies from Database",
        () {
      expect(
          movieModel.getTopRatedMoviesFromDatabase(),
          emits([
            MovieVO(
                false,
                "/kCEXA22ASuq7Y29jnngyaisyA0X.jpg",
                [878, 9648, 12],
                62,
                "en",
                "2001: A Space Odyssey",
                "Humanity finds a mysterious object buried beneath the lunar surface and sets off to find its origins with the help of HAL 9000, the world's most advanced super computer.",
                37.981,
                "/ve72VxNqjGM69Uky4WTo2bK6rfq.jpg",
                "1968-04-02",
                "2001: A Space Odyssey",
                false,
                8.1,
                10149,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                false,
                false,
                true),
          ]));
    });

    test("Get Genre Test", () {
      expect(movieModel.getGenres(), completion(equals(getMockGenres())));
    });

    test("Get Actors Test", () {
      expect(movieModel.getActors(1), completion(equals(getMockActors())));
    });

    test("Get Credits Test", () {
      expect(movieModel.getCreditsByMovie(1),
          completion(equals(getMockCredits())));
    });

    test("Get Movie Detail Test", () {
      expect(movieModel.getMovieDetails(1),
          completion(equals(getMockMoviesForTest().first)));
    });

    test("Get Actors from database test", () async {
      await movieModel.getActors(1);
      expect(movieModel.getAllActorsFromDatabase(),
          completion(equals(getMockActors())));
    });

    test("Get MovieDetails from database test", () async {
      await movieModel.getMovieDetails(1);
      expect(movieModel.getMovieDetails(1),
          completion(equals(getMockMoviesForTest().first)));
    });

    test("Get Genres from database test", () async {
      await movieModel.getGenres();
      expect(movieModel.getGenresFromDatabase(),
          completion(equals(getMockGenres())));
    });
  });


}
