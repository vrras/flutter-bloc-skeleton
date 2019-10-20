import 'package:bloc_pattern_mark1/src/blocs/movies-popular.bloc.dart';
import 'package:bloc_pattern_mark1/src/models/movies-popular.dart';
import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  final MoviesPopularBloc _bloc;

  MovieList(this._bloc);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    widget._bloc.init();
    widget._bloc.fetchAllMoviesPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uflix'),
      ),
      body: StreamBuilder(
        stream: widget._bloc.allMoviesPopular,
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
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailPage(snapshot.data, index),
            ),
          );
        });
  }

  openDetailPage(MoviesPopular data, int index) {
    Navigator.pushNamed(
      context,
      'movieDetail', arguments: data.results[index]);
  }

  @override
  void dispose() {
    widget._bloc.dispose();
    super.dispose();
  }
}
