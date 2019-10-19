
import 'dart:convert';
import 'package:bloc_pattern_mark1/src/models/movies-popular.dart';
import 'package:http/http.dart';

class MoviesPopularProvider {
  Client client = Client();
  final _apiKey = 'eec9a4b36055a26c5669162b10c810dd';

  Future<MoviesPopular> fetchMoviesPopularList() async {
    print('entered');
    final response = await client.get('http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey');
    print(response.body.toString());

    if (response.statusCode == 200) {
      return MoviesPopular.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }
}