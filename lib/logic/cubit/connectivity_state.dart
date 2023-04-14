part of 'connectivity_cubit.dart';

enum ConnectionType {
  Wifi,
  Mobile,
}

@immutable
abstract class ConnectivityState {}

class ConnectivityLoading extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {
  final ConnectionType connectionType;

  ConnectivityConnected({required this.connectionType});
}

class ConnectivityDisconnected extends ConnectivityState {}
