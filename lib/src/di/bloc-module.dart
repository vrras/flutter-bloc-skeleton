import 'package:bloc_pattern_mark1/src/blocs/bloc-base.dart';
import 'package:bloc_pattern_mark1/src/blocs/movie-detail.bloc.dart';
import 'package:bloc_pattern_mark1/src/blocs/movies-popular.bloc.dart';
import 'package:bloc_pattern_mark1/src/resources/network.provider.dart';
import 'package:bloc_pattern_mark1/src/resources/repository.dart';
import 'package:inject/inject.dart';
import 'package:http/http.dart';

@module
class BlocModule {
  @provide
  @singleton
  Client client() => Client();

  @provide
  @singleton
  NetworkProvider networkProvider(Client client) => NetworkProvider(client);

  @provide
  @singleton
  Repository repository(NetworkProvider networkProvider) => Repository(networkProvider);

  @provide
  BlocBase moviesPopularBloc(Repository repository) => MoviesPopularBloc(repository);

  @provide
  BlocBase movieDetailBloc(Repository repository) => MovieDetailBloc(repository);
}