part of 'constraints_form_bloc.dart';

@immutable
class ConstraintsFormState extends Equatable {
  const ConstraintsFormState({
    this.numberOfJugglers = const NumberOfJugglers.pure(),
    this.period = const Period.pure(),
    this.numberOfObjects = const NumberOfObjects.pure(),
    this.maxHeight = const MaxHeight.pure(),
    this.minNumberOfPasses = const MinNumberOfPasses.pure(),
    this.maxNumberOfPasses = const MaxNumberOfPasses.pure(),
    this.contains = const Contains.pure(),
    this.status = FormzStatus.valid,
    this.listOfPatterns = const [],
    this.error,
  });

  final NumberOfJugglers numberOfJugglers;
  final Period period;
  final NumberOfObjects numberOfObjects;
  final MaxHeight maxHeight;
  final MinNumberOfPasses minNumberOfPasses;
  final MaxNumberOfPasses maxNumberOfPasses;
  final Contains contains;
  final FormzStatus status;
  final List<Pattern> listOfPatterns;
  final dynamic error;

  @override
  List<Object?> get props => [
        numberOfJugglers,
        period,
        numberOfObjects,
        maxHeight,
        minNumberOfPasses,
        maxNumberOfPasses,
        contains,
        status,
        listOfPatterns,
        error,
      ];

  ConstraintsFormState copyWith({
    NumberOfJugglers? numberOfJugglers,
    Period? period,
    NumberOfObjects? numberOfObjects,
    MaxHeight? maxHeight,
    MinNumberOfPasses? minNumberOfPasses,
    MaxNumberOfPasses? maxNumberOfPasses,
    Contains? contains,
    FormzStatus? status,
    List<Pattern>? listOfPatterns,
    dynamic error = '###!!!###',
  }) {
    return ConstraintsFormState(
      numberOfJugglers: numberOfJugglers ?? this.numberOfJugglers,
      period: period ?? this.period,
      numberOfObjects: numberOfObjects ?? this.numberOfObjects,
      maxHeight: maxHeight ?? this.maxHeight,
      minNumberOfPasses: minNumberOfPasses ?? this.minNumberOfPasses,
      maxNumberOfPasses: maxNumberOfPasses ?? this.maxNumberOfPasses,
      contains: contains ?? this.contains,
      status: status ?? this.status,
      listOfPatterns: listOfPatterns ?? this.listOfPatterns,
      error: error != '###!!!###' ? error : this.error,
    );
  }

  SearchParameters toSearchParameters() => SearchParameters(
        numberOfJugglers: numberOfJugglers.value,
        period: period.value,
        numberOfObjects: numberOfObjects.value,
        maxHeight: maxHeight.value,
        minNumberOfPasses: minNumberOfPasses.value ?? -1,
        maxNumberOfPasses: maxNumberOfPasses.value ?? -1,
        contains: contains.value ?? '',
      );
}
