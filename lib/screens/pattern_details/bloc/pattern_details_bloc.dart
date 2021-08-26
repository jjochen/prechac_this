import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pattern_details_event.dart';
part 'pattern_details_state.dart';

class PatternDetailsBloc extends Bloc<PatternDetailsEvent, PatternDetailsState> {
  PatternDetailsBloc() : super(PatternDetailsInitial());

  @override
  Stream<PatternDetailsState> mapEventToState(
    PatternDetailsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
