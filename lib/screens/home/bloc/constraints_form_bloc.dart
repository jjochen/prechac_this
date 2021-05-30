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
          add(PattersDidLoad());
        }
        // TODO: PatternsNotLoaded
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
    } else if (event is Submit) {
      yield* _mapSubmitToState(event);
    } else if (event is PattersDidLoad) {
      yield* _mapPatternsDidLoadToState(event);
    } else if (event is PattersDidNotLoad) {
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
    PattersDidLoad event,
  ) async* {
    yield state.copyWith(
      status: FormzStatus.submissionSuccess,
      errorMessage: '',
    );
  }

  Stream<ConstraintsFormState> _mapPatternsDidNotLoadToState(
    PattersDidNotLoad event,
  ) async* {
    yield state.copyWith(
      status: FormzStatus.submissionFailure,
      errorMessage: event.errorMessage,
    );
  }

  ConstraintsFormState _copyStateWithFormValues({
    NumberOfJugglers? numberOfJugglers,
    Period? period,
    NumberOfObjects? numberOfObjects,
    MaxHeight? maxHeight,
  }) {
    return state.copyWith(
      numberOfJugglers: numberOfJugglers,
      period: period,
      numberOfObjects: numberOfObjects,
      maxHeight: maxHeight,
      status: Formz.validate([
        numberOfJugglers ?? state.numberOfJugglers,
        period ?? state.period,
        numberOfObjects ?? state.numberOfObjects,
        maxHeight ?? state.maxHeight,
      ]),
      errorMessage: '',
    );
  }

  @override
  Future<void> close() {
    _patternsSubscription?.cancel();
    return super.close();
  }
}
