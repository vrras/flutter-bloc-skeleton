import 'package:bloc_pattern_mark1/src/app.dart';
import 'package:bloc_pattern_mark1/src/di/bloc-module.dart';
import 'package:inject/inject.dart';
import 'bloc-injector.inject.dart' as g;

@Injector(const [BlocModule])
abstract class BlocInjector{
  @provide
  App get app;

  static final create = g.BlocInjector$Injector.create;
}