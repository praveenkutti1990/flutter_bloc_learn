import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learn/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc_learn/presentation/screens/home_screen.dart';
import 'package:flutter_bloc_learn/presentation/screens/second_screen.dart';
import 'package:flutter_bloc_learn/presentation/screens/third_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterCubit _conterCubit = CounterCubit();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        '/': (context) => BlocProvider.value(
            value: _conterCubit,
            child: const HomeScreen(
                title: 'Home Screen', color: Colors.blueAccent)),
        '/second': (context) => BlocProvider.value(
            value: _conterCubit,
            child: const SecondScreen(
                title: 'Second Screen', color: Colors.orangeAccent)),
        '/third': (context) => BlocProvider.value(
            value: _conterCubit,
            child: const ThirdScreen(
                title: 'Third Screen', color: Colors.redAccent)),
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _conterCubit.close();
    super.dispose();
  }
}
