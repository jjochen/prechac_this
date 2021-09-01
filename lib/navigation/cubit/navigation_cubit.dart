import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void navigateToListOfPatterns(List<Pattern> patterns) {
    emit(NavigationState(listOfPatterns: patterns));
  }

  void navigateToPatternDetailView(Pattern pattern) {
    emit(
      NavigationState(
        listOfPatterns: state.listOfPatterns,
        currentPattern: pattern,
      ),
    );
  }

  void pop() {
    if (state.showAttributions) {
      emit(
        NavigationState(
          listOfPatterns: state.listOfPatterns,
          currentPattern: state.currentPattern,
        ),
      );
    } else if (state.currentPattern != null) {
      emit(NavigationState(listOfPatterns: state.listOfPatterns));
    } else {
      emit(const NavigationState());
    }
  }
}
