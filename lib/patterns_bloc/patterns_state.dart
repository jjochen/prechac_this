part of 'patterns_bloc.dart';

@immutable
abstract class PatternsState extends Equatable {
  const PatternsState();

  @override
  List<Object> get props => [];
}

class PatternsInitial extends PatternsState {}

class PatternsLoading extends PatternsState {}

class PatternsLoaded extends PatternsState {
  const PatternsLoaded([this.patterns = const []]);

  final List<Pattern> patterns;

  @override
  List<Object> get props => [patterns];
}

class PatternsNotLoaded extends PatternsState {
  const PatternsNotLoaded(this.exception);

  final Object exception;

  @override
  List<Object> get props => [exception];
}
