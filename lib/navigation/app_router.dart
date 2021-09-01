import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prechac_this/navigation/navigation.dart';
import 'package:prechac_this/screens/attributions/attributions.dart';
import 'package:prechac_this/screens/home/home.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

class AppRouter {
  static PageRoute pageRoute(
    Widget child,
    RoutingData data,
  ) =>
      MaterialPageRoute<dynamic>(
        builder: (context) => child,
        settings: RouteSettings(
          name: data.fullRoute,
          arguments: data,
        ),
      );

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final name = settings.name;
    final data = name?.routingData ?? const RoutingData();

    Route<dynamic>? route;
    route ??= _tryParseAttributionsRoute(data);
    route ??= _homeRoute(data);
    return route;
  }

  static PageRoute<dynamic> _homeRoute(RoutingData data) {
    //final map = data.queryParameters;
    //final searchParameters = SearchParameters.fromQueryParameters(map);

    return pageRoute(
      const HomePage(),
      data,
    );
  }

  static PageRoute<dynamic>? _tryParseAttributionsRoute(RoutingData data) {
    if (AttributionsPage.routeName != data.firstPathSegment) {
      return null;
    }

    return pageRoute(const AttributionsPage(), data);
  }
}

class RoutingData extends Equatable {
  const RoutingData([
    this.pathSegments = const [],
    this.queryParameters = const {},
  ]);

  final List<String> pathSegments;
  final Map<String, String> queryParameters;

  @override
  List<Object?> get props => [pathSegments, queryParameters];

  //@override
  //int get hashCode => route.hashCode;

  String get firstPathSegment => pathSegments.isEmpty ? '' : pathSegments.first;

  String get fullRoute => Uri(
          pathSegments: pathSegments,
          queryParameters: queryParameters.isEmpty ? null : queryParameters)
      .toString();

  String? operator [](String key) => queryParameters[key];
}

extension RoutingDataString on String {
  RoutingData get routingData {
    final uri = Uri.parse(this);

    return RoutingData(
      uri.pathSegments,
      uri.queryParameters,
    );
  }
}

class AppRouterDelegate extends RouterDelegate<AppRouter>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRouter> {
  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return Navigator(
        key: navigatorKey,
        pages: [
          const MaterialPage<dynamic>(child: HomePage()),
          if (state.listOfPatterns != null)
            const MaterialPage<dynamic>(child: SearchResultsPage()),
          // if (state.currentPattern != null)
          //   const MaterialPage<dynamic>(child: PatternDetailsPage()),
          if (state.showAttributions)
            const MaterialPage<dynamic>(child: AttributionsPage()),
        ],
        onPopPage: (Route<dynamic> route, dynamic result) {
          BlocProvider.of<NavigationCubit>(context).pop();
          return route.didPop(result);
        },
      );
    });
  }

  // We don't use named navigation so we don't use this
  @override
  Future<void> setNewRoutePath(AppRouter configuration) async {}
}
