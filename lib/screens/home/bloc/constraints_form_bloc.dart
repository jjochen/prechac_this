import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/home/home.dart';

part 'constraints_form_event.dart';
part 'constraints_form_state.dart';

class ConstraintsFormBloc
    extends Bloc<ConstraintsFormEvent, ConstraintsFormState> {
  ConstraintsFormBloc({required this.patternsRepository})
      : super(const ConstraintsFormState()) {
    on<NumberOfJugglersDidChange>(_onNumbersOfJugglersDidChange);
    on<PeriodDidChange>(_onPeriodDidChange);
    on<NumberOfObjectsDidChange>(_onNumberOfObjectsDidChange);
    on<MaxHeightDidChange>(_onMaxHeightDidChange);
    on<MinNumberOfPassesDidChange>(_onMinNumberOfPassesDidChange);
    on<MaxNumberOfPassesDidChange>(_onMaxNumberOfPassesDidChange);
    on<ContainsDidChange>(_onContainsDidChange);
    on<Submit>(_onSubmit);
  }

  final PatternsRepository patternsRepository;

  Future<void> _onNumbersOfJugglersDidChange(
    NumberOfJugglersDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = NumberOfJugglers.dirty(event.numberOfJugglers);
    emit(_copyStateWithFormValues(numberOfJugglers: value));
  }

  Future<void> _onPeriodDidChange(
    PeriodDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = Period.dirty(event.period);
    emit(_copyStateWithFormValues(period: value));
  }

  Future<void> _onNumberOfObjectsDidChange(
    NumberOfObjectsDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = NumberOfObjects.dirty(event.numberOfObjects);
    emit(_copyStateWithFormValues(numberOfObjects: value));
  }

  Future<void> _onMaxHeightDidChange(
    MaxHeightDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = MaxHeight.dirty(event.maxHeight);
    emit(_copyStateWithFormValues(maxHeight: value));
  }

  Future<void> _onMinNumberOfPassesDidChange(
    MinNumberOfPassesDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = MinNumberOfPasses.dirty(event.minNumberOfPasses);
    emit(_copyStateWithFormValues(minNumberOfPasses: value));
  }

  Future<void> _onMaxNumberOfPassesDidChange(
    MaxNumberOfPassesDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = MaxNumberOfPasses.dirty(event.maxNumberOfPasses);
    emit(_copyStateWithFormValues(maxNumberOfPasses: value));
  }

  Future<void> _onContainsDidChange(
    ContainsDidChange event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    final value = Contains.dirty(event.contains);
    emit(_copyStateWithFormValues(contains: value));
  }

  Future<void> _onSubmit(
    Submit event,
    Emitter<ConstraintsFormState> emit,
  ) async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
        listOfPatterns: null,
        exception: null,
      ),
    );
    await patternsRepository
        .patterns(state.toSearchParameters())
        .then(
          (patterns) => emit(
            state.copyWith(
              status: FormzStatus.submissionSuccess,
              listOfPatterns: patterns,
              exception: null,
            ),
          ),
        )
        .onError<Exception>(
          (Exception exception, StackTrace stackTrace) => emit(
            state.copyWith(
              status: FormzStatus.submissionFailure,
              exception: exception,
            ),
          ),
        );
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
      exception: null,
      listOfPatterns: null,
    );
  }
}
