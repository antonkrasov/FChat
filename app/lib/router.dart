import 'package:fchat/ui/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'splash':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: RouteSettings(isInitialRoute: true),
        );
    }

    throw 'Can\'t build a route for ${settings.name}';
  }
}
