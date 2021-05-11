import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pattern_repository/pattern_repository.dart';

import '../attributions/attributions.dart';
import '../home/home.dart';
import '../search_results/search_results.dart';

class AppRouter {
  static PageRoute pageRoute(
    Widget child,
    RoutingData data,
  ) =>
      MaterialPageRoute(
        builder: (context) => child,
        settings: RouteSettings(
          name: data.fullRoute,
          arguments: data,
        ),
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
    final searchParameters = SearchParameters.fromQueryParameters(map);

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

extension RoutingDataString on String {
  RoutingData get routingData {
    final uri = Uri.parse(this);

    return RoutingData(
      uri.pathSegments,
      uri.queryParameters,
    );
  }
}
