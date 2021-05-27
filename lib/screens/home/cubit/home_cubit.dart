import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import '../../../pattern_repository/pattern_repository.dart';
import '../models/models.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void numberOfJugglersChanged(int value) {
    final numberOfJugglers = NumberOfJugglers.dirty(value);
    emit(state.copyWith(
      numberOfJugglers: numberOfJugglers,
      status: _validate(
        numberOfJugglers: numberOfJugglers,
      ),
    ));
  }

  void periodChanged(int value) {
    final period = Period.dirty(value);
    emit(state.copyWith(
      period: period,
      status: _validate(
        period: period,
      ),
    ));
  }

  void numberOfObjectsChanged(int value) {
    final numberOfObjects = NumberOfObjects.dirty(value);
    emit(state.copyWith(
      numberOfObjects: numberOfObjects,
      status: _validate(
        numberOfObjects: numberOfObjects,
      ),
    ));
  }

  void maxHeightChanged(int value) {
    final maxHeight = MaxHeight.dirty(value);
    emit(state.copyWith(
      maxHeight: maxHeight,
      status: _validate(
        maxHeight: maxHeight,
      ),
    ));
  }

  Future<void> submit() async {
    if (!state.status.isValidated) {
      return;
    }
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    emit(state.copyWith(status: FormzStatus.submissionSuccess));
  }

  FormzStatus _validate({
    NumberOfJugglers? numberOfJugglers,
    Period? period,
    NumberOfObjects? numberOfObjects,
    MaxHeight? maxHeight,
  }) {
    return Formz.validate([
      numberOfJugglers ?? state.numberOfJugglers,
      period ?? state.period,
      numberOfObjects ?? state.numberOfObjects,
      maxHeight ?? state.maxHeight,
    ]);
  }
}
