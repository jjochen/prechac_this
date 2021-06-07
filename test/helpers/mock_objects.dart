import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

class MockPatternsBloc extends MockBloc<PatternsEvent, PatternsState>
    implements PatternsBloc {}

class FakePatternsEvent extends Fake implements PatternsEvent {}

final mockParameters = SearchParameters(
  numberOfJugglers: 2,
  period: 4,
  numberOfObjects: 4,
  maxHeight: 4,
);

final mockPattern = Pattern(
  numberOfJugglers: 2,
  throwSequence: [
    Throw.self(height: 4),
    Throw.pass(height: 2),
    Throw.self(height: 1),
    Throw.pass(height: 1),
  ],
);
