import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

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

  void navigateToAttributions() {
    emit(
      NavigationState(
        listOfPatterns: state.listOfPatterns,
        currentPattern: state.currentPattern,
        showAttributions: true,
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
