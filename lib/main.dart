import 'package:flutter/material.dart';
import 'package:movie_app/network/retrofit_movie_data_agent_impl.dart';

import 'pages/home_page.dart';

void main() {
  // HttpMovieDataAgentImpl().getNowPlayingMovies(1);
  // DioMovieDataAgentImpl().getNowPlayingMovies(1);
  RetrofitMovieDataAgentImpl().getNowPlayingMovies(1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
