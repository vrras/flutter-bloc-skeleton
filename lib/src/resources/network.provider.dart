import 'dart:convert';
import 'package:bloc_pattern_mark1/src/models/movies-popular.dart';
import 'package:bloc_pattern_mark1/src/models/state.dart';
import 'package:bloc_pattern_mark1/src/models/trailer.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:inject/inject.dart';

class NetworkProvider {
  Client client;
  final _apiKey = 'eec9a4b36055a26c5669162b10c810dd';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  @provide
  NetworkProvider(this.client);

  Future<State> fetchMoviesPopularList() async {
    Response response;
    if (_apiKey != 'api-key') {
      response = await client
          .get('http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey');
    } else {
      return State<String>.error('Please add your API key');
    }

    if (response.statusCode == 200) {
      return State<MoviesPopular>.success(MoviesPopular.fromJson(json.decode(response.body)));
    } else {
      return State<String>.error('Failed to load movie');
    }
  }

  Future<State> fetchTrailers(int movieId) async {
    final response =
        await client.get('$_baseUrl/$movieId/videos?api_key=$_apiKey');

    if (response.statusCode == 200) {
      return State<Trailer>.success(Trailer.fromJson(json.decode(response.body)));
    } else {
      return State<String>.error(response.statusCode.toString());
    }
  }
}
