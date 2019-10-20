import 'package:bloc_pattern_mark1/src/models/movies-popular.dart';
import 'package:bloc_pattern_mark1/src/models/trailer.dart';
import 'package:bloc_pattern_mark1/src/resources/network.provider.dart';
import 'package:inject/inject.dart';

class Repository {
  NetworkProvider networkProvider;

  @provide
  Repository(this.networkProvider);

  Future<MoviesPopular> fetchMoviesPopularList() =>
      networkProvider.fetchMoviesPopularList();

  Future<Trailer> fetchTrailers(int movieId) =>
      networkProvider.fetchTrailers(movieId);
}
