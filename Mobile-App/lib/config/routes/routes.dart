import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/features/pages/home/home.dart';

class MyRoutes {
  Route? onRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        throw Exception('Invalid Route');
    }
  }
}
