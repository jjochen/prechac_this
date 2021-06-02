import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    }
  }

  Stream<PatternsState> _mapLoadPatternsToState(LoadPatterns event) async* {
    yield PatternsLoading();
    final patterns = await _patternsRepository.patterns(event.searchParameters);
    add(PatternsUpdated(patterns));
  }

  Stream<PatternsState> _mapPatternsUpdatedToState(
      PatternsUpdated event) async* {
    yield PatternsLoaded(event.patterns);
  }
}