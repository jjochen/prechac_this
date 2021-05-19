import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pedantic/pedantic.dart';

import '../../../repositories/pattern_repository/pattern_repository.dart';

part 'patterns_event.dart';
part 'patterns_state.dart';

class PatternsBloc extends Bloc<PatternsEvent, PatternsState> {
  PatternsBloc({
    required PatternRepository patternRepository,
  })   : _patternRepository = patternRepository,
        super(PatternsInitial());

  final PatternRepository _patternRepository;
  StreamSubscription? _patternSubscription;

  @override
  Stream<PatternsState> mapEventToState(
    PatternsEvent event,
  ) async* {
    if (event is LoadPatterns) {
      yield* _mapLoadPatternsToState(event);
    } else if (event is PatternsUpdated) {
      yield* _mapPatternsUpdatedToState(event);
    }
  }

  Stream<PatternsState> _mapLoadPatternsToState(LoadPatterns event) async* {
    unawaited(_patternSubscription?.cancel());
    final patterns = await _patternRepository.patterns(event.searchParameters);
    add(PatternsUpdated(patterns));
  }

  Stream<PatternsState> _mapPatternsUpdatedToState(
      PatternsUpdated event) async* {
    yield PatternsLoaded(event.patterns);
  }

  @override
  Future<void> close() {
    _patternSubscription?.cancel();
    return super.close();
  }
}
