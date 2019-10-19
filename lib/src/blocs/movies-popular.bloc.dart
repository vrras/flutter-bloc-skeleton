import 'package:bloc_pattern_mark1/src/models/movies-popular.dart';
import 'package:bloc_pattern_mark1/src/resources/movies-popular.repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesPopularBloc {
  final _moviesPopularRepository = MoviePopularRepository();
  final _moviesPopularFetcher = PublishSubject<MoviesPopular>();

  Observable<MoviesPopular> get allMoviesPopular => _moviesPopularFetcher.stream;

  fetchAllMoviesPopular() async {
    MoviesPopular moviesPopular = await _moviesPopularRepository.fetchMoviesPopularList();
    _moviesPopularFetcher.sink.add(moviesPopular);
  }

  dispose() {
    _moviesPopularFetcher.close();
  }
}

final moviesPopularBloc = MoviesPopularBloc();