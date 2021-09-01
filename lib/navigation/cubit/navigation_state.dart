part of 'navigation_cubit.dart';

@immutable
class NavigationState extends Equatable {
  const NavigationState({
    this.listOfPatterns,
    this.currentPattern,
    this.showAttributions = false,
  });

  final List<Pattern>? listOfPatterns;
  final Pattern? currentPattern;
  final bool showAttributions;

  @override
  List<Object?> get props => [
        listOfPatterns,
        currentPattern,
        showAttributions,
      ];
}
