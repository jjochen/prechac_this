import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../attributions/attributions.dart';
import '../core/core.dart';
import '../home/home.dart';
import '../search_results/search_results.dart';

class AppRouter {
  static PageRoute pageRoute(
    Widget child,
    RoutingData data,
  ) =>
      _FadeRoute(
        child,
        data.fullRoute,
        data,
      );

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final name = settings.name;
    final RoutingData data;
    if (name == null) {
      data = RoutingData();
    } else {
      data = name.routingData;
    }

    Route<dynamic>? route;

    route ??= _parseAttributionsRoute(data);

    route ??= _parseSearchResultsRoute(data);

    route ??= pageRoute(HomePage(), data);

    return route;
  }

  static PageRoute<dynamic>? _parseAttributionsRoute(RoutingData data) {
    if (AttributionsPage.routeName != data.firstSegment) {
      return null;
    }

    return pageRoute(AttributionsPage(), data);
  }

  static PageRoute<dynamic>? _parseSearchResultsRoute(RoutingData data) {
    if (SearchResultsPage.routeName != data.firstSegment) {
      return null;
    }

    final map = data.queryParameters;
    final searchParameters = MappedSearchParameters.fromQuery(map);

    return pageRoute(
      SearchResultsPage(searchParameters: searchParameters),
      data,
    );
  }
}

class RoutingData extends Equatable {
  RoutingData([
    this.route = const [],
    this.queryParameters = const {},
  ]);

  final List<String> route;
  final Map<String, String> queryParameters;

  @override
  List<Object?> get props => [route, queryParameters];

  //@override
  //int get hashCode => route.hashCode;

  String get firstSegment => route.isEmpty ? '' : route.first;

  String get fullRoute => Uri(
          pathSegments: route,
          queryParameters: queryParameters.isEmpty ? null : queryParameters)
      .toString();

  String? operator [](String key) => queryParameters[key];
}

extension MappedSearchParameters on SearchParameters {
  static SearchParameters fromQuery(Map<String, String> map) {
    final numberOfJuggers = map.intForKey('number_of_jugglers', fallback: -1);
    final period = map.intForKey('period', fallback: -1);
    final numberOfObjects = map.intForKey('number_of_objects', fallback: -1);
    final maxHeight = map.intForKey('max_height', fallback: -1);
    final minNumberOfPasses =
        map.intForKey('min_number_of_passes', fallback: -1);
    final maxNumberOfPasses =
        map.intForKey('max_number_of_passes', fallback: -1);

    return SearchParameters(
      numberOfJugglers: numberOfJuggers,
      period: period,
      numberOfObjects: numberOfObjects,
      maxHeight: maxHeight,
      minNumberOfPasses: minNumberOfPasses,
      maxNumberOfPasses: maxNumberOfPasses,
    );
  }
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

class _FadeRoute extends PageRouteBuilder {
  _FadeRoute(
    this.child,
    this.routeName,
    this.data,
  ) : super(
          settings: RouteSettings(
            name: routeName,
            arguments: data,
          ),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  final Widget child;
  final String routeName;
  final RoutingData data;
}
