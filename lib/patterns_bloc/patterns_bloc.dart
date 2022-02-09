import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

part 'patterns_event.dart';
part 'patterns_state.dart';

class PatternsBloc extends Bloc<PatternsEvent, PatternsState> {
  PatternsBloc({
    required PatternsRepository patternsRepository,
  })  : _patternsRepository = patternsRepository,
        super(PatternsInitial()) {
    on<LoadPatterns>(_onLoadPatterns);
    on<PatternsUpdated>(_onPatternsUpdated);
    on<PatternsNotUpdated>(_onPatternsNotUpdated);
  }

  final PatternsRepository _patternsRepository;

  Future<void> _onLoadPatterns(
    LoadPatterns event,
    Emitter<PatternsState> emit,
  ) async {
    emit(PatternsLoading());
    await _patternsRepository
        .patterns(event.searchParameters)
        .then((patterns) => add(PatternsUpdated(patterns)))
        .catchError((Object error) => add(PatternsNotUpdated(error)));
  }

  Future<void> _onPatternsUpdated(
    PatternsUpdated event,
    Emitter<PatternsState> emit,
  ) async {
    emit(PatternsLoaded(event.patterns));
  }

  Future<void> _onPatternsNotUpdated(
    PatternsNotUpdated event,
    Emitter<PatternsState> emit,
  ) async {
    emit(PatternsNotLoaded(event.exception));
  }
}
