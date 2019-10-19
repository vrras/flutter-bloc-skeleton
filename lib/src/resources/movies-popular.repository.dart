import 'package:bloc_pattern_mark1/src/models/movies-popular.dart';
import 'package:bloc_pattern_mark1/src/resources/movies-popular.provider.dart';

class MoviePopularRepository {
  final moviesPopularProvider = MoviesPopularProvider();

  Future<MoviesPopular> fetchMoviesPopularList() =>
      moviesPopularProvider.fetchMoviesPopularList();
}
