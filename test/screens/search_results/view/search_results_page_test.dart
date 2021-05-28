import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';
import 'package:prechac_this/screens/search_results/widgets/widgets.dart';

import '../../../helpers/helpers.dart';

class MockPatternsBloc extends MockBloc<PatternsEvent, PatternsState>
    implements PatternsBloc {}

class FakePatternsEvent extends Fake implements PatternsEvent {}

void main() {
  group('SearchResultsPage', () {
    testWidgets('renders SearchResultsView', (tester) async {
      await tester.pumpApp(
        widget: SearchResultsPage(
          searchParameters: mockParameters,
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
      final state = PatternsLoaded([mockPattern]);
      when(() => searchResultsBloc.state).thenReturn(state);
      await tester.pumpApp(
        widget: BlocProvider.value(
          value: searchResultsBloc,
          child: SearchResultsView(),
        ),
      );
      expect(find.byKey(Key('__pattern_item_$mockPattern')), findsOneWidget);
    });
  });
}
