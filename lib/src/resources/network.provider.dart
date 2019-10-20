import 'dart:convert';
import 'package:bloc_pattern_mark1/src/models/movies-popular.dart';
import 'package:bloc_pattern_mark1/src/models/trailer.dart';
import 'package:http/http.dart';
import 'package:inject/inject.dart';

class NetworkProvider {
  Client client;
  final _apiKey = 'eec9a4b36055a26c5669162b10c810dd';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  @provide
  NetworkProvider(this.client);

  Future<MoviesPopular> fetchMoviesPopularList() async {
    Response response;
    if (_apiKey != 'api-key') {
      response = await client
          .get('http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey');
    } else {
      throw Exception('Please add your API key');
    }

    if (response.statusCode == 200) {
      return MoviesPopular.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Future<Trailer> fetchTrailers(int movieId) async {
    final response =
        await client.get('$_baseUrl/$movieId/videos?api_key=$_apiKey');

    if (response.statusCode == 200) {
      return Trailer.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}
