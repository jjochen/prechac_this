// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

import '../../../helpers/helpers.dart';

class MockPatternsBloc extends MockBloc<PatternsEvent, PatternsState>
    implements PatternsBloc {}

class FakePatternsEvent extends Fake implements PatternsEvent {}

void main() {
  group('SearchResultsPage', () {
    late PatternsBloc patternsBloc;

    setUp(() {
      registerFallbackValue(FakePatternsEvent());
      registerFallbackValue(PatternsInitial());
      patternsBloc = MockPatternsBloc();
    });

    testWidgets('renders list of patterns', (tester) async {
      when(() => patternsBloc.state).thenReturn(
        PatternsLoaded([mockPattern]),
      );
      await tester.pumpApp(
        patternsBloc: patternsBloc,
        widget: SearchResultsPage(),
      );
      expect(
        find.byKey(Key('__pattern_item_${mockPattern.id}')),
        findsOneWidget,
      );
    });
  });
}
