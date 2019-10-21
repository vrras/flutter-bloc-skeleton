import 'dart:io';
import 'package:bloc_pattern_mark1/src/di/bloc-injector.dart';
import 'package:bloc_pattern_mark1/src/resources/network.provider.dart';
import 'package:inject/inject.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_pattern_mark1/src/models/state.dart';
import 'package:bloc_pattern_mark1/src/models/movies-popular.dart';
import 'package:bloc_pattern_mark1/src/models/trailer.dart';

import 'provider-module.dart';

void main() {
  group("NetworkProvider test", () {
    test("fetchMovieList success test", () async {
      var container = await ProviderTestInjector.create(ProviderModule());
      var app = container.app;
      var mockClient = app.mockClient;
      when(mockClient.get(
              "http://api.themoviedb.org/3/movie/popular?api_key=eec9a4b36055a26c5669162b10c810dd"))
          .thenAnswer((_) async => http.Response(
                  '{"page": 1,"total_results": 19832,"total_pages": 992,"results": [{"vote_count": 302,"id": 420818,"video": false,"vote_average": 6.8,"title": "The Lion King","popularity": 502.676,"poster_path": "/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg","original_language": "en","original_title": "The Lion King","genre_ids": [12,16,10751,18,28],"backdrop_path": "/1TUg5pO1VZ4B0Q1amk3OlXvlpXV.jpg","adult": false,"overview": "Simba idolises his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub\'s arrival. Scar, Mufasa\'s brother—and former heir to the throne—has plans of his own. The battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba\'s exile. With help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his.","release_date": "2019-07-12"}]}',
                  200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  }));
      expect(await app.networkProvider.fetchMovieList(),
          isInstanceOf<SuccessState<MoviesPopular>>());
    });

    test("fetchMovieList fail test", () async {
      var container = await ProviderTestInjector.create(ProviderModule());
      var app = container.app;
      var mockClient = app.mockClient;
      when(mockClient.get(
              "http://api.themoviedb.org/3/movie/popular?api_key=eec9a4b36055a26c5669162b10c810dd"))
          .thenAnswer((_) async => http.Response(
                  '{"status_code":7,"status_message":"Invalid API key: You must be granted a valid key.","success":false}',
                  401,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  }));
      expect(await app.networkProvider.fetchMovieList(),
          isInstanceOf<ErrorState>());
    });

    test("fetchTrailer success test", () async {
      var container = await ProviderTestInjector.create(ProviderModule());
      var app = container.app;
      var mockClient = app.mockClient;
      when(mockClient.get(
              "http://api.themoviedb.org/3/movie/420818/videos?api_key=eec9a4b36055a26c5669162b10c810dd"))
          .thenAnswer((_) async => http.Response(
                  '{"id": 420818,"results": [{"id": "5bf75c2f0e0a26266f0e1e04","iso_639_1": "en","iso_3166_1": "US","key": "4CbLXeGSDxg","name": "The Lion King Official Teaser Trailer","site": "YouTube","size": 1080,"type": "Teaser"}]}',
                  200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  }));
      expect(await app.networkProvider.fetchTrailer(420818),
          isInstanceOf<SuccessState<Trailer>>());
    });

    test("fetchTrailer fail test", () async {
      var container = await ProviderTestInjector.create(ProviderModule());
      var app = container.app;
      var mockClient = app.mockClient;
      when(mockClient.get(
              "http://api.themoviedb.org/3/movie/428/videos?api_key=eec9a4b36055a26c5669162b10c810dd"))
          .thenAnswer((_) async => http.Response(
                  '{"id": 428,"results": []}', 401, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));
      expect(await app.networkProvider.fetchTrailer(428),
          isInstanceOf<ErrorState>());
    });
  });
}

class ProviderTest {
  final NetworkProvider networkProvider;
  final http.Client mockClient;

  @provide
  ProviderTest(this.networkProvider, this.mockClient) : super();
}