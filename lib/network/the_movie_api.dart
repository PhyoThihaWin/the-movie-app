import 'package:dio/dio.dart' hide Headers;
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/response/get_actors_response.dart';
import 'package:movie_app/network/response/get_genres_response.dart';
import 'package:movie_app/network/response/get_now_playing_response.dart';
import 'package:retrofit/http.dart';

part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieApi {
  factory TheMovieApi(Dio dio) = _TheMovieApi;

  @GET(ENDPOINT_GET_NOW_PLAYING)
  Future<MovieListResponse> getNowPlayingMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) int page,
  );

  @GET(ENDPOINT_GET_TOP_RATED)
  Future<MovieListResponse> getTopRatedMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) int page,
  );

  @GET(ENDPOINT_GET_POPULAR)
  Future<MovieListResponse> getPopularMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) int page,
  );

  @GET(ENDPOINT_GET_GENRES)
  Future<GetGenresResponse> getGenres(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
  );

  @GET(ENDPOINT_GET_MOVIES_BY_GENRES)
  Future<MovieListResponse> getMoviesByGenre(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_GENRE_ID) String genreId,
  );

  @GET(ENDPOINT_GET_ACTORS)
  Future<GetActorsResponse> getActors(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) int page,
  );
}
