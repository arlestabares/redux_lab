import 'package:equatable/equatable.dart';

/// ¿Por qué un enum?
/// Porque ahora tenemos cuatro estados posibles claramente identificados. Es más expresivo que manejar
/// varios booleanos como isLoading, hasError e isAuthenticated, que podrían terminar en combinaciones
/// contradictorias.
enum AuthStatus { unauthenticated, loading, authenticated, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? username;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.username,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, username, errorMessage];
}
