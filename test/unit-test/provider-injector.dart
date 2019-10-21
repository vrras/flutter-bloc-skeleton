import 'package:inject/inject.dart';
import 'provider-injector.inject.dart' as g;
import 'provider-test.dart';
import 'provider-module.dart';

@Injector(const [ProviderModule])
abstract class ProviderTestInjector{
  @provide
  ProviderTest get app;

  static final create = g.ProviderTestInjector$Injector.create;
}