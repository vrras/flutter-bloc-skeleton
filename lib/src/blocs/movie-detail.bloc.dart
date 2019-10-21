import 'package:bloc_pattern_mark1/src/blocs/bloc-base.dart';
import 'package:bloc_pattern_mark1/src/models/state.dart';
import 'package:bloc_pattern_mark1/src/models/trailer.dart';
import 'package:bloc_pattern_mark1/src/resources/repository.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc extends BlocBase {
  final Repository _repository;
  BehaviorSubject<Trailer> _trailers;

  Observable<Trailer> get movieTrailers => _trailers.stream;

  init() {
    _trailers = BehaviorSubject<Trailer>();
  }

  @provide
  MovieDetailBloc(this._repository);

  void fetchTrailersById(id) async {
    final state = await _repository.fetchTrailers(id);
    if (state is SuccessState) {
      _trailers.sink.add(state.value);
    } else {
      _trailers.addError((state as ErrorState).msg);
    }
  }

  @override
  dispose() async {
    await _trailers.drain();
    _trailers.close();
  }
}