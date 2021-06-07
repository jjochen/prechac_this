import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../screens/attributions/attributions.dart';
import '../screens/home/home.dart';

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
    final data = name?.routingData ?? const RoutingData();

    Route<dynamic>? route;
    route ??= _tryParseAttributionsRoute(data);
    route ??= _homeRoute(data);
    return route;
  }

  static PageRoute<dynamic> _homeRoute(RoutingData data) {
    // TODO: fill form with search parameters
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
