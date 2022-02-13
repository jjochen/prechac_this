// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/home/home.dart';

class MockPatternsBloc extends MockBloc<PatternsEvent, PatternsState>
    implements PatternsBloc {}

class MockConstraintsFormBloc
    extends MockBloc<ConstraintsFormEvent, ConstraintsFormState>
    implements ConstraintsFormBloc {}

class MockPatternsRepository extends Mock implements PatternsRepository {}

class MockNumberOfJugglers extends Mock implements NumberOfJugglers {}

class MockPeriod extends Mock implements Period {}

class MockNumberOfObjects extends Mock implements NumberOfObjects {}

class MockMaxHeight extends Mock implements MaxHeight {}

class MockMinNumberOfPasses extends Mock implements MinNumberOfPasses {}

class MockMaxNumberOfPasses extends Mock implements MaxNumberOfPasses {}

class MockContains extends Mock implements Contains {}

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
