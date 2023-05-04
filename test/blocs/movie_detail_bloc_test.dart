import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/blocs/movie_details_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Movie detail bloc test", () {
    MovieDetailsBloc? movieDetailBloc;

    setUp(() {
      movieDetailBloc = MovieDetailsBloc(1, MovieModelImplMock());
    });

    test("Fetch Movie Detail Test", () {
      expect(movieDetailBloc?.movieDetails, getMockMoviesForTest().first);
    });

    test("Fetch Creator Test", () {
      expect(movieDetailBloc?.crew?.contains(getMockActors().first), true);
    });

    test("Fetch Actor Test", () {
      expect(movieDetailBloc?.cast?.contains(getMockActors().last), true);
    });


    test("Fetch Related Movies Test", () async{
      movieDetailBloc?.getRelatedMovies(3);
      await Future.delayed(const Duration(microseconds: 500));
      expect(movieDetailBloc?.relatedMovies?.contains(getMockMoviesForTest().last),
          true);
    });

  });
}
