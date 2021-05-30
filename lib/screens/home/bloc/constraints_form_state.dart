part of 'constraints_form_bloc.dart';

@immutable
class ConstraintsFormState extends Equatable {
  const ConstraintsFormState({
    this.numberOfJugglers = const NumberOfJugglers.pure(),
    this.period = const Period.pure(),
    this.numberOfObjects = const NumberOfObjects.pure(),
    this.maxHeight = const MaxHeight.pure(),
    this.status = FormzStatus.valid,
    this.errorMessage = '',
  });

  final NumberOfJugglers numberOfJugglers;
  final Period period;
  final NumberOfObjects numberOfObjects;
  final MaxHeight maxHeight;
  final FormzStatus status;
  final String errorMessage;

  @override
  List<Object> get props => [
        numberOfJugglers,
        period,
        numberOfObjects,
        maxHeight,
        status,
        errorMessage,
      ];

  ConstraintsFormState copyWith({
    NumberOfJugglers? numberOfJugglers,
    Period? period,
    NumberOfObjects? numberOfObjects,
    MaxHeight? maxHeight,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return ConstraintsFormState(
      numberOfJugglers: numberOfJugglers ?? this.numberOfJugglers,
      period: period ?? this.period,
      numberOfObjects: numberOfObjects ?? this.numberOfObjects,
      maxHeight: maxHeight ?? this.maxHeight,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  SearchParameters toSearchParameters() => SearchParameters(
        numberOfJugglers: numberOfJugglers.value,
        period: period.value,
        numberOfObjects: numberOfObjects.value,
        maxHeight: maxHeight.value,
      );
}
