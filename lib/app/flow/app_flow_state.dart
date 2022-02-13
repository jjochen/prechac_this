part of 'app_flow.dart';

@immutable
class AppFlowState extends Equatable {
  const AppFlowState({
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

  AppFlowState copyWith({
    List<Pattern>? listOfPatterns,
    Pattern? currentPattern,
    bool? showAttributions,
  }) {
    return AppFlowState(
      listOfPatterns: listOfPatterns ?? this.listOfPatterns,
      currentPattern: currentPattern ?? this.currentPattern,
      showAttributions: showAttributions ?? this.showAttributions,
    );
  }
}
