part of 'constraints_form_bloc.dart';

abstract class ConstraintsFormEvent extends Equatable {
  const ConstraintsFormEvent();

  @override
  List<Object> get props => [];
}

class NumberOfJugglersDidChange extends ConstraintsFormEvent {
  const NumberOfJugglersDidChange(this.numberOfJugglers);

  final int numberOfJugglers;

  @override
  List<Object> get props => [numberOfJugglers];
}

class PeriodDidChange extends ConstraintsFormEvent {
  const PeriodDidChange(this.period);

  final int period;

  @override
  List<Object> get props => [period];
}

class NumberOfObjectsDidChange extends ConstraintsFormEvent {
  const NumberOfObjectsDidChange(this.numberOfObjects);

  final int numberOfObjects;

  @override
  List<Object> get props => [numberOfObjects];
}

class MaxHeightDidChange extends ConstraintsFormEvent {
  const MaxHeightDidChange(this.maxHeight);

  final int maxHeight;

  @override
  List<Object> get props => [maxHeight];
}

class MinNumberOfPassesDidChange extends ConstraintsFormEvent {
  const MinNumberOfPassesDidChange(this.minNumberOfPasses);

  final int minNumberOfPasses;

  @override
  List<Object> get props => [minNumberOfPasses];
}

class MaxNumberOfPassesDidChange extends ConstraintsFormEvent {
  const MaxNumberOfPassesDidChange(this.maxNumberOfPasses);

  final int maxNumberOfPasses;

  @override
  List<Object> get props => [maxNumberOfPasses];
}

class ContainsDidChange extends ConstraintsFormEvent {
  const ContainsDidChange(this.contains);

  final String contains;

  @override
  List<Object> get props => [contains];
}

class Submit extends ConstraintsFormEvent {}

class PatternsDidLoad extends ConstraintsFormEvent {}

class PatternsDidNotLoad extends ConstraintsFormEvent {
  const PatternsDidNotLoad(this.exception);

  final Exception exception;

  @override
  List<Object> get props => [exception];
}
