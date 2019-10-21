import 'package:bloc_pattern_mark1/src/di/bloc-injector.inject.dart';
import 'package:inject/inject.dart';
import 'package:bloc_pattern_mark1/src/blocs/movies-popular.bloc.dart';
import 'package:bloc_pattern_mark1/src/blocs/movie-detail.bloc.dart';
import 'package:bloc_pattern_mark1/src/models/movies-popular.dart';
import 'package:bloc_pattern_mark1/src/models/trailer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern_mark1/src/di/bloc-injector.dart';
import 'package:bloc_pattern_mark1/src/di/bloc-module.dart';

void main() async {
  group("BloC testing", (){
    test("Movie BLoC testing", () async {
      var container = await BlocInjector$Injector.create(BlocModule());
      var moviesBloc = container.app.moviesBloc;
      moviesBloc.init();
      moviesBloc.fetchAllMovies();
      moviesBloc.allMovies.listen(expectAsync1((value){
        expect(value, isInstanceOf<MoviesPopular>());
      }));
    });
    test("Movie Detail BLoC testing", () async {
      var container = await BlocInjector$Injector.create(BlocModule());
      var moviesBloc = container.app.movieDetailBloc;
      moviesBloc.init();
      moviesBloc.fetchTrailersById(420818);
      moviesBloc.movieTrailers.listen(expectAsync1((value){
        expect(value, isInstanceOf<Trailer>());
      }));
    });
  });
}
class BlocTest{
  final MoviesPopularBloc moviesBloc;
  final MovieDetailBloc movieDetailBloc;

  @provide
  BlocTest(this.moviesBloc, this.movieDetailBloc): super();

}