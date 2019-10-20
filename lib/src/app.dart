import 'package:bloc_pattern_mark1/src/blocs/movie-detail.bloc.dart';
import 'package:bloc_pattern_mark1/src/blocs/movies-popular.bloc.dart';
import 'package:bloc_pattern_mark1/src/models/movies-popular.dart';
import 'package:bloc_pattern_mark1/src/ui/movie-detail.dart';
import 'package:bloc_pattern_mark1/src/ui/movie-list.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

class App extends StatelessWidget {
  final MoviesPopularBloc moviesBloc;
  final MovieDetailBloc movieDetailBloc;

  @provide
  App(this.moviesBloc, this.movieDetailBloc): super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if(settings.name == 'movieDetail'){
          final Result result = settings.arguments;
          return MaterialPageRoute(
            builder: (context){
              return MovieDetail(
                movieDetailBloc,
                result.title,
                result.overview,
                result.releaseDate,
                result.backdropPath,
                result.voteAverage.toString(),
                result.id,
              );
            }
          );
        }
      },
      routes: {
        '/': (context) => MovieList(moviesBloc),
      },
    );
  }
}