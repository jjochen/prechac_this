import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../patterns_repository/patterns_repository.dart';

part 'patterns_event.dart';
part 'patterns_state.dart';

class PatternsBloc extends Bloc<PatternsEvent, PatternsState> {
  PatternsBloc({
    required PatternsRepository patternsRepository,
  })  : _patternsRepository = patternsRepository,
        super(PatternsInitial());

  final PatternsRepository _patternsRepository;

  @override
  Stream<PatternsState> mapEventToState(
    PatternsEvent event,
  ) async* {
    if (event is LoadPatterns) {
      yield* _mapLoadPatternsToState(event);
    } else if (event is PatternsUpdated) {
      yield* _mapPatternsUpdatedToState(event);
    } else if (event is PatternsNotUpdated) {
      yield* _mapPatternsNotUpdatedToState(event);
    }
  }

  Stream<PatternsState> _mapLoadPatternsToState(LoadPatterns event) async* {
    yield PatternsLoading();
    await _patternsRepository
        .patterns(event.searchParameters)
        .then((patterns) => add(PatternsUpdated(patterns)))
        .catchError((error) => add(PatternsNotUpdated(error)));
  }

  Stream<PatternsState> _mapPatternsUpdatedToState(
      PatternsUpdated event) async* {
    yield PatternsLoaded(event.patterns);
  }

  Stream<PatternsState> _mapPatternsNotUpdatedToState(
      PatternsNotUpdated event) async* {
    yield PatternsNotLoaded(event.exception);
  }
}
