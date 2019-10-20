import 'package:bloc_pattern_mark1/src/blocs/bloc-base.dart';
import 'package:bloc_pattern_mark1/src/models/trailer.dart';
import 'package:bloc_pattern_mark1/src/resources/repository.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc extends BlocBase {
  final Repository _repository;
  PublishSubject<int> _movieId;
  BehaviorSubject<Future<Trailer>> _trailers;

  @provide
  MovieDetailBloc(this._repository);

  Function(int) get fetchTrailersById => _movieId.sink.add;
  Observable<Future<Trailer>> get movieTrailers => _trailers.stream;

  init() {
    _movieId = PublishSubject<int>();
    _trailers = BehaviorSubject<Future<Trailer>>();
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  @override
  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
      (Future<Trailer> trailer, int id, int index) {
        print(index);
        trailer = _repository.fetchTrailers(id);
        return trailer;
      },
    );
  }
}