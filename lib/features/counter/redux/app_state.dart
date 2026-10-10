import 'package:equatable/equatable.dart';

import '../../auth/redux/auth_state.dart';

class AppState extends Equatable {
  final int counter;
  // final bool isAuthenticated;
  final AuthState auth;
  final String dashboardMessage;

  const AppState({
    this.counter = 0,
    // this.isAuthenticated = false,
    this.auth = const AuthState(),
    this.dashboardMessage = 'Bienvenido al Redux Enterprise Lab',
  });

  @override
  List<Object?> get props => [counter, auth, dashboardMessage];
}
