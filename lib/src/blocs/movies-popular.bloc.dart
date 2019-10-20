import 'package:bloc_pattern_mark1/src/blocs/bloc-base.dart';
import 'package:bloc_pattern_mark1/src/models/movies-popular.dart';
import 'package:bloc_pattern_mark1/src/resources/repository.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

class MoviesPopularBloc extends BlocBase {
  Repository _repository;
  PublishSubject<MoviesPopular> _moviesPopularFetcher;

  @provide
  MoviesPopularBloc(this._repository);

  init() {
    _moviesPopularFetcher = PublishSubject<MoviesPopular>();
  }

  Observable<MoviesPopular> get allMoviesPopular => _moviesPopularFetcher.stream;

  fetchAllMoviesPopular() async {
    MoviesPopular moviesPopular = await _repository.fetchMoviesPopularList();
    _moviesPopularFetcher.sink.add(moviesPopular);
  }

  @override
  dispose() {
    _moviesPopularFetcher.close();
  }
}