import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../../patterns_bloc/patterns_bloc.dart';
import '../../../patterns_repository/patterns_repository.dart';
import '../home.dart';

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
  }

  final PatternsBloc _patternsBloc;
  StreamSubscription? _patternsSubscription;

  @override
  Stream<ConstraintsFormState> mapEventToState(
    ConstraintsFormEvent event,
  ) async* {
    if (event is NumberOfJugglersDidChange) {
      yield* _mapNumbersOfJugglersDidChangeToState(event);
    } else if (event is PeriodDidChange) {
      yield* _mapPeriodDidChangeToState(event);
    } else if (event is NumberOfObjectsDidChange) {
      yield* _mapNumberOfObjectsDidChangeToState(event);
    } else if (event is MaxHeightDidChange) {
      yield* _mapMaxHeightDidChangeToState(event);
    } else if (event is MinNumberOfPassesDidChange) {
      yield* _mapMinNumberOfPassesDidChangeToState(event);
    } else if (event is MaxNumberOfPassesDidChange) {
      yield* _mapMaxNumberOfPassesDidChangeToState(event);
    } else if (event is ContainsDidChange) {
      yield* _mapContainsDidChangeToState(event);
    } else if (event is Submit) {
      yield* _mapSubmitToState(event);
    } else if (event is PatternsDidLoad) {
      yield* _mapPatternsDidLoadToState(event);
    } else if (event is PatternsDidNotLoad) {
      yield* _mapPatternsDidNotLoadToState(event);
    }
  }

  Stream<ConstraintsFormState> _mapNumbersOfJugglersDidChangeToState(
    NumberOfJugglersDidChange event,
  ) async* {
    final value = NumberOfJugglers.dirty(event.numberOfJugglers);
    yield _copyStateWithFormValues(numberOfJugglers: value);
  }

  Stream<ConstraintsFormState> _mapPeriodDidChangeToState(
    PeriodDidChange event,
  ) async* {
    final value = Period.dirty(event.period);
    yield _copyStateWithFormValues(period: value);
  }

  Stream<ConstraintsFormState> _mapNumberOfObjectsDidChangeToState(
    NumberOfObjectsDidChange event,
  ) async* {
    final value = NumberOfObjects.dirty(event.numberOfObjects);
    yield _copyStateWithFormValues(numberOfObjects: value);
  }

  Stream<ConstraintsFormState> _mapMaxHeightDidChangeToState(
    MaxHeightDidChange event,
  ) async* {
    final value = MaxHeight.dirty(event.maxHeight);
    yield _copyStateWithFormValues(maxHeight: value);
  }

  Stream<ConstraintsFormState> _mapMinNumberOfPassesDidChangeToState(
    MinNumberOfPassesDidChange event,
  ) async* {
    final value = MinNumberOfPasses.dirty(event.minNumberOfPasses);
    yield _copyStateWithFormValues(minNumberOfPasses: value);
  }

  Stream<ConstraintsFormState> _mapMaxNumberOfPassesDidChangeToState(
    MaxNumberOfPassesDidChange event,
  ) async* {
    final value = MaxNumberOfPasses.dirty(event.maxNumberOfPasses);
    yield _copyStateWithFormValues(maxNumberOfPasses: value);
  }

  Stream<ConstraintsFormState> _mapContainsDidChangeToState(
    ContainsDidChange event,
  ) async* {
    final value = Contains.dirty(event.contains);
    yield _copyStateWithFormValues(contains: value);
  }

  Stream<ConstraintsFormState> _mapSubmitToState(
    Submit event,
  ) async* {
    yield state.copyWith(
      status: FormzStatus.submissionInProgress,
      errorMessage: '',
    );
    _patternsBloc.add(LoadPatterns(state.toSearchParameters()));
  }

  Stream<ConstraintsFormState> _mapPatternsDidLoadToState(
    PatternsDidLoad event,
  ) async* {
    yield state.copyWith(
      status: FormzStatus.submissionSuccess,
      errorMessage: '',
    );
  }

  Stream<ConstraintsFormState> _mapPatternsDidNotLoadToState(
    PatternsDidNotLoad event,
  ) async* {
    yield state.copyWith(
      status: FormzStatus.submissionFailure,
      errorMessage: errorMessage(event.exception),
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
      errorMessage: '',
    );
  }

  String errorMessage(Exception exception) {
    if (exception is ConstraintsInvalidException) {
      return 'Could not parse constraints.';
    }

    if (exception is NoPatternsFoundException) {
      return 'No patterns found.';
    }

    return 'unknown error';
  }

  @override
  Future<void> close() {
    _patternsSubscription?.cancel();
    return super.close();
  }
}
