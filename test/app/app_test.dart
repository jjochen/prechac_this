// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:bloc_test/bloc_test.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/app.dart';
import 'package:prechac_this/app/flow/app_flow.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/home/home.dart';

import '../helpers/helpers.dart';

void main() {
  group('App', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late PatternsBloc patternsBloc;
    late FlowController<AppFlowState> flowController;

    setUp(() {
      flowController = FakeFlowController<AppFlowState>(AppFlowState());
      patternsBloc = MockPatternsBloc();
      whenListen(
        patternsBloc,
        Stream<PatternsState>.empty(),
        initialState: PatternsInitial(),
      );
    });

    testWidgets('renders HomePage', (tester) async {
      await tester.pumpApp(
        providers: [BlocProvider<PatternsBloc>(create: (_) => patternsBloc)],
        flowController: flowController,
        child: AppView(),
      );
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
