import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learn/logic/cubit/connectivity_cubit.dart';
import 'package:flutter_bloc_learn/logic/cubit/counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});
  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<ConnectivityCubit, ConnectivityState>(
              builder: (context, state) {
                if (state is ConnectivityConnected &&
                    state.connectionType == ConnectionType.Wifi) {
                  return const Text(
                    'Wi-Fi',
                  );
                } else if (state is ConnectivityConnected &&
                    state.connectionType == ConnectionType.Mobile) {
                  return const Text(
                    'Mobile',
                  );
                } else if (state is ConnectivityDisconnected) {
                  return const Text(
                    'Disconnected',
                  );
                }
                return const Text(
                  'Loading',
                );
              },
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Incremented'),
                    duration: Duration(milliseconds: 300),
                  ));
                }
                if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Decremented'),
                    duration: Duration(milliseconds: 300),
                  ));
                }
              },
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Builder(builder: ((context) {
              final internetCubitState =
                  context.watch<ConnectivityCubit>().state;
              final counterCubitState = context.watch<CounterCubit>().state;
              if (internetCubitState is ConnectivityConnected &&
                  internetCubitState.connectionType == ConnectionType.Mobile) {
                return Text(
                    "Counter: ${counterCubitState.counterValue} Internet: Mobile");
              } else if (internetCubitState is ConnectivityConnected &&
                  internetCubitState.connectionType == ConnectionType.Wifi) {
                return Text(
                    "Counter: ${counterCubitState.counterValue} Internet: Wifi");
              } else {
                return Text(
                    "Counter: ${counterCubitState.counterValue} Internet: Disconnected");
              }
            })),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              color: widget.color,
              onPressed: () {
                Navigator.of(context).pushNamed("/second");
              },
              child: const Text("Go to Second Screen"),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              color: widget.color,
              onPressed: () {
                Navigator.of(context).pushNamed("/third");
              },
              child: const Text("Go to Third Screen"),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
