import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/repositories/pattern_repository/pattern_repository.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';
import 'package:prechac_this/screens/search_results/widgets/widgets.dart';

import '../../../helpers/helpers.dart';

class MockPatternsBloc extends MockBloc<PatternsEvent, PatternsState>
    implements PatternsBloc {}

class FakePatternsEvent extends Fake implements PatternsEvent {}

void main() {
  final searchParameters = SearchParameters(
    numberOfJugglers: 2,
    period: 4,
    numberOfObjects: 4,
    maxHeight: 4,
  );

  final pattern = Pattern([
    Throw.self(height: 4),
    Throw.pass(height: 2),
    Throw.self(height: 1),
    Throw.pass(height: 1),
  ]);

  group('SearchResultsPage', () {
    testWidgets('renders SearchResultsView', (tester) async {
      await tester.pumpApp(
        widget: SearchResultsPage(
          searchParameters: searchParameters,
        ),
      );
      expect(find.byType(SearchResultsView), findsOneWidget);
    });
  });

  group('SearchResultsView', () {
    late PatternsBloc searchResultsBloc;

    setUp(() {
      registerFallbackValue(FakePatternsEvent());
      registerFallbackValue(PatternsInitial());
      searchResultsBloc = MockPatternsBloc();
    });

    testWidgets('renders loading view', (tester) async {
      final state = PatternsLoading();
      when(() => searchResultsBloc.state).thenReturn(state);
      await tester.pumpApp(
        widget: BlocProvider.value(
          value: searchResultsBloc,
          child: SearchResultsView(),
        ),
      );
      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('renders list of patterns', (tester) async {
      final state = PatternsLoaded([pattern]);
      when(() => searchResultsBloc.state).thenReturn(state);
      await tester.pumpApp(
        widget: BlocProvider.value(
          value: searchResultsBloc,
          child: SearchResultsView(),
        ),
      );
      expect(find.byKey(Key('__pattern_item_$pattern')), findsOneWidget);
    });
  });
}