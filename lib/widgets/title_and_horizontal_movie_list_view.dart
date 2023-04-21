import 'package:flutter/material.dart';
import 'package:movie_app/pages/smart_list_view.dart';
import 'package:movie_app/widgets/title_text.dart';

import '../data/vos/movie_vo.dart';
import '../resources/dimens.dart';
import '../viewitems/movie_view.dart';

class TitleAndHorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? getNowPlayingMovies;
  final String title;
  final Function onListEndReached;

  TitleAndHorizontalMovieListView(
    this.onTapMovie,
    this.getNowPlayingMovies, {
    required this.title,
    required this.onListEndReached,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(title),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          onTapMovie: onTapMovie,
          movieList: getNowPlayingMovies,
          onListEndReached: onListEndReached,
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;
  final Function onListEndReached;

  HorizontalMovieListView({
    required this.onTapMovie,
    required this.movieList,
    required this.onListEndReached,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: movieList?.isNotEmpty ?? false
          // ? ListView.builder(
          //     itemCount: movieList?.length ?? 0,
          //     padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) {
          //       return MovieView(
          //           onTapMovie: onTapMovie, movie: movieList?[index]);
          //     },
          //   )
          ? SmartHorizontalListView(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              itemCount: movieList?.length ?? 0,
              itemBuilder: (context, index) {
                return MovieView(
                    onTapMovie: onTapMovie, movie: movieList?[index]);
              },
              onListEndReached: () {
                onListEndReached();
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
