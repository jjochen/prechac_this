import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/home/home.dart';

part 'constraints_form_event.dart';
part 'constraints_form_state.dart';

class ConstraintsFormBloc
    extends Bloc<ConstraintsFormEvent, ConstraintsFormState> {
  ConstraintsFormBloc({required PatternsBloc patternsBloc})
      : _patternsBloc = patternsBloc,
        super(const ConstraintsFormState()) {
    _patternsSubscription = patternsBloc.stream.listen(
      (state) {
        if (state is PatternsLoaded) {
          add(PatternsDidLoad());
        } else if (state is PatternsNotLoaded) {
          add(PatternsDidNotLoad(state.exception));
        }
      },
    );
    on<NumberOfJugglersDidChange>(_onNumbersOfJugglersDidChangeToState);
    on<PeriodDidChange>(_onPeriodDidChangeToState);
    on<NumberOfObjectsDidChange>(_onNumberOfObjectsDidChangeToState);
    on<MaxHeightDidChange>(_onMaxHeightDidChangeToState);
    on<MinNumberOfPassesDidChange>(_onMinNumberOfPassesDidChangeToState);
    on<MaxNumberOfPassesDidChange>(_onMaxNumberOfPassesDidChangeToState);
    on<ContainsDidChange>(_onContainsDidChangeToState);
    on<Submit>(_onSubmitToState);
    on<PatternsDidLoad>(_onPatternsDidLoadToState);
    on<PatternsDidNotLoad>(_onPatternsDidNotLoadToState);
  }

  final PatternsBloc _patternsBloc;
  StreamSubscription? _patternsSubscription;

  Future<void> _onNumbersOfJugglersDidChangeToState(
    NumberOfJugglersDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = NumberOfJugglers.dirty(event.numberOfJugglers);
    emit(_copyStateWithFormValues(numberOfJugglers: value));
  }

  Future<void> _onPeriodDidChangeToState(
    PeriodDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = Period.dirty(event.period);
    emit(_copyStateWithFormValues(period: value));
  }

  Future<void> _onNumberOfObjectsDidChangeToState(
    NumberOfObjectsDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = NumberOfObjects.dirty(event.numberOfObjects);
    emit(_copyStateWithFormValues(numberOfObjects: value));
  }

  Future<void> _onMaxHeightDidChangeToState(
    MaxHeightDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = MaxHeight.dirty(event.maxHeight);
    emit(_copyStateWithFormValues(maxHeight: value));
  }

  Future<void> _onMinNumberOfPassesDidChangeToState(
    MinNumberOfPassesDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = MinNumberOfPasses.dirty(event.minNumberOfPasses);
    emit(_copyStateWithFormValues(minNumberOfPasses: value));
  }

  Future<void> _onMaxNumberOfPassesDidChangeToState(
    MaxNumberOfPassesDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = MaxNumberOfPasses.dirty(event.maxNumberOfPasses);
    emit(_copyStateWithFormValues(maxNumberOfPasses: value));
  }

  Future<void> _onContainsDidChangeToState(
    ContainsDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = Contains.dirty(event.contains);
    emit(_copyStateWithFormValues(contains: value));
  }

  Future<void> _onSubmitToState(
    Submit event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
      error: null,
    ));
    _patternsBloc.add(LoadPatterns(state.toSearchParameters()));
  }

  Future<void> _onPatternsDidLoadToState(
    PatternsDidLoad event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionSuccess,
      error: null,
    ));
  }

  Future<void> _onPatternsDidNotLoadToState(
    PatternsDidNotLoad event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionFailure,
      error: event.exception,
    ));
  }

  ConstraintsFormState _copyStateWithFormValues({
    NumberOfJugglers? numberOfJugglers,
    Period? period,
    NumberOfObjects? numberOfObjects,
    MaxHeight? maxHeight,
    MinNumberOfPasses? minNumberOfPasses,
    MaxNumberOfPasses? maxNumberOfPasses,
    Contains? contains,
  }) {
    return state.copyWith(
      numberOfJugglers: numberOfJugglers,
      period: period,
      numberOfObjects: numberOfObjects,
      maxHeight: maxHeight,
      minNumberOfPasses: minNumberOfPasses,
      maxNumberOfPasses: maxNumberOfPasses,
      contains: contains,
      status: Formz.validate([
        numberOfJugglers ?? state.numberOfJugglers,
        period ?? state.period,
        numberOfObjects ?? state.numberOfObjects,
        maxHeight ?? state.maxHeight,
        minNumberOfPasses ?? state.minNumberOfPasses,
        maxNumberOfPasses ?? state.maxNumberOfPasses,
        contains ?? state.contains,
      ]),
      error: null,
    );
  }

  @override
  Future<void> close() {
    _patternsSubscription?.cancel();
    return super.close();
  }
}
