import 'package:fchat/ui/screens/chat.dart';
import 'package:fchat/ui/screens/home.dart';
import 'package:fchat/ui/screens/login.dart';
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
      case 'login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case 'home':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case 'chat':
        return MaterialPageRoute(
          builder: (_) => ChatScreen(),
        );
    }

    throw 'Can\'t build a route for ${settings.name}';
  }
}
