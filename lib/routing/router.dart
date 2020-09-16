import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:grocery_app/views/fail/fail_age.dart';
import 'package:grocery_app/views/home/home_view.dart';
import 'package:grocery_app/views/app/main_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(HomeView(), settings.name);
    // case AboutRoute:
    //   return _getPageRoute(AboutView(), settings.name);
    // case EpisodesRoute:
    //   return _getPageRoute(EpisodesView(), settings.name);
    // case GamesRoute:
    //   return _getPageRoute(EmbededGame(), settings.name);
    case AppRoute:
      return _getPageRoute(App(), settings.name);
    case FailAgeRoute:
      return _getPageRoute(FailAgeView(), settings.name);
    default:
  }
}

PageRoute _getPageRoute(Widget child, String routeName) {
  return _FadeRoute(child: child, routeName: routeName);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                child,
            settings: RouteSettings(name: routeName),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ));
}
