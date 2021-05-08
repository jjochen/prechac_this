import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../attributions/attributions.dart';
import '../home/home.dart';

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

    final route = data.route;
    final firstRouteSegment = route.isEmpty ? '' : route.first;
    switch (firstRouteSegment) {
      case AttributionsPage.routeName:
        {
          return pageRoute(AttributionsPage(), data);
        }
      default:
        {
          return pageRoute(HomePage(), data);
        }
    }
  }
}

class RoutingData extends Equatable {
  RoutingData([
    this.route = const [],
    Map<String, String> queryParameters = const {},
  ]) : _queryParameters = queryParameters;

  final List<String> route;
  final Map<String, String> _queryParameters;

  @override
  List<Object?> get props => [route, _queryParameters];

  //@override
  //int get hashCode => route.hashCode;

  String get fullRoute => Uri(
          pathSegments: route,
          queryParameters: _queryParameters.isEmpty ? null : _queryParameters)
      .toString();

  String? operator [](String key) => _queryParameters[key];
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
