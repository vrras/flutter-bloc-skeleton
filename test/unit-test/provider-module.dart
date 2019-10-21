import 'package:bloc_pattern_mark1/src/resources/network.provider.dart';
import 'package:inject/inject.dart';
import 'package:http/http.dart' as http;

import 'mock-client.dart';

@module
class ProviderModule{

  @provide
  @singleton
  http.Client client() => MockClient();

  @provide
  @singleton
  NetworkProvider movieApiProvider(http.Client client) => NetworkProvider(client);
}