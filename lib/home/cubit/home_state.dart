part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  const HomeState({
    this.numberOfJugglers = const NumberOfJugglers.pure(),
    this.period = const Period.pure(),
    this.numberOfObjects = const NumberOfObjects.pure(),
    this.maxHeight = const MaxHeight.pure(),
    this.status = FormzStatus.pure,
  });

  final NumberOfJugglers numberOfJugglers;
  final Period period;
  final NumberOfObjects numberOfObjects;
  final MaxHeight maxHeight;
  final FormzStatus status;

  @override
  List<Object> get props => [
        numberOfJugglers,
        period,
        numberOfObjects,
        maxHeight,
        status,
      ];

  HomeState copyWith({
    NumberOfJugglers? numberOfJugglers,
    Period? period,
    NumberOfObjects? numberOfObjects,
    MaxHeight? maxHeight,
    FormzStatus? status,
  }) {
    return HomeState(
      numberOfJugglers: numberOfJugglers ?? this.numberOfJugglers,
      period: period ?? this.period,
      numberOfObjects: numberOfObjects ?? this.numberOfObjects,
      maxHeight: maxHeight ?? this.maxHeight,
      status: status ?? this.status,
    );
  }
}