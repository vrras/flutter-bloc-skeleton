import 'package:bloc_pattern_mark1/src/blocs/movies-popular.bloc.dart';
import 'package:bloc_pattern_mark1/src/models/movies-popular.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    moviesPopularBloc.fetchAllMoviesPopular();
    return Scaffold(
      appBar: AppBar(title: Text('Uflix'),),
      body: StreamBuilder(
        stream: moviesPopularBloc.allMoviesPopular,
        builder: (context, AsyncSnapshot<MoviesPopular> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<MoviesPopular> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.results.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}',
          fit: BoxFit.cover,
        );
      },
    );
  }
}