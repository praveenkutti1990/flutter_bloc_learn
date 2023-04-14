import 'package:flutter/material.dart';

import '../../logic/cubit/counter_cubit.dart';
import '../screens/home_screen.dart';
import '../screens/second_screen.dart';
import '../screens/third_screen.dart';

class AppRouter {
  final CounterCubit _conterCubit = CounterCubit();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => const HomeScreen(
                title: 'Home Screen', color: Colors.blueAccent));
      case '/second':
        return MaterialPageRoute(
            builder: (context) => const SecondScreen(
                title: 'Second Screen', color: Colors.orangeAccent));
      case '/third':
        return MaterialPageRoute(
            builder: (context) => const ThirdScreen(
                title: 'Third Screen', color: Colors.redAccent));
      default:
        return null;
    }
  }

  dispose() {
    _conterCubit.close();
  }
}
