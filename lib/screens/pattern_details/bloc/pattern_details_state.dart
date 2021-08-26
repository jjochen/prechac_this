part of 'pattern_details_bloc.dart';

abstract class PatternDetailsState extends Equatable {
  const PatternDetailsState();
  
  @override
  List<Object> get props => [];
}

class PatternDetailsInitial extends PatternDetailsState {}
