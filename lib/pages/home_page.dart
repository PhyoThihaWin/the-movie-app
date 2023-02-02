import 'package:flutter/material.dart';
import 'package:movie_app/viewitems/actor_view.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/banner_view.dart';
import '../viewitems/movie_view.dart';
import '../viewitems/showcase_view.dart';
import '../widgets/title_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        centerTitle: true,
        title: const Text(
          MAIN_SCREEN_APP_BAR_TITLE,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: MARGIN_MEDIUM_2),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        color: PRIMARY_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerSectionView(),
              SizedBox(height: MARGIN_LARGE),
              BestPopularMoviesAndSerialsSectionView(),
              SizedBox(height: MARGIN_LARGE),
              HorizontalMovieListView(),
              SizedBox(height: MARGIN_LARGE),
              ShowcasesSection(),
              SizedBox(height: MARGIN_LARGE),
              BestActorSectionView(),
              SizedBox(height: MARGIN_LARGE)
            ],
          ),
        ),
      ),
    );
  }
}

class BestActorSectionView extends StatelessWidget {
  const BestActorSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: TitleTextWithSeeMoreView(
              BEST_ACTOR_TITLE, BEST_ACTOR_SEE_MORE),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        Container(
          height: BEST_ACTOR_HEIGHT,
          child: ListView(
            padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            scrollDirection: Axis.horizontal,
            children: [
              ActorView(),
              ActorView(),
              ActorView(),
            ],
          ),
        ),
      ],
    );
  }
}

class ShowcasesSection extends StatelessWidget {
  const ShowcasesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: TitleTextWithSeeMoreView(SHOWCASES_TITLE, SHOWCASES_SEE_MORE),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          height: SHOWCASES_HEIGHT,
          child: ListView(
            padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            scrollDirection: Axis.horizontal,
            children: [
              ShowCaseView(),
              ShowCaseView(),
              ShowCaseView(),
            ],
          ),
        ),
      ],
    );
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  const BestPopularMoviesAndSerialsSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(MAIN_SCREEN_BEST_POPULAR_MOVIES_AND_SERIALS),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  const HorizontalMovieListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const MovieView();
        },
      ),
    );
  }
}

class BannerSectionView extends StatelessWidget {
  const BannerSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: PageView(
        children: const [
          BannerView(),
          BannerView(),
          BannerView(),
        ],
      ),
    );
  }
}
