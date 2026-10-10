import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final int counter;
  final bool isAuthenticated;
  final String dashboardMessage;

  const AppState({
    this.counter = 0,
    this.isAuthenticated = false,
    this.dashboardMessage = 'Bienvenido al Redux Enterprise Lab',
  });

  @override
  List<Object?> get props => [counter, isAuthenticated, dashboardMessage];
}
