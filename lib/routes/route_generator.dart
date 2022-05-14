import 'package:flutter/material.dart';

import '../screens/screen_movie_detail.dart';
import '../screens/screen_home.dart';
import '../screens/screen_movie_list.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    dynamic args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const ScreenHome(),
        );
      case '/screen_movie_list':
        return MaterialPageRoute(
          builder: (_) => ScreenMovieList(
            screen: args,
          ),
        );
      case '/screen_movie_detail':
        return MaterialPageRoute(
          builder: (_) => ScreenMovieDetail(
            argument: args,
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ERROR'),
        ),
        body: const Center(
          child: Text('Error ::: path'),
        ),
      );
    });
  }
}
