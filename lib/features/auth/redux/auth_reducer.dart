import 'auth_actions.dart';
import 'auth_state.dart';

AuthState authReducer(AuthState state, dynamic action) {
  if (action is LoginRequestedAction) {
    return const AuthState(status: AuthStatus.loading);
  }

  if (action is LoginSucceededAction) {
    return AuthState(
      status: AuthStatus.authenticated,
      username: action.username,
    );
  }

  if (action is LoginFailedAction) {
    return AuthState(status: AuthStatus.failure, errorMessage: action.message);
  }

  if (action is LogoutAction) {
    return const AuthState();
  }

  return state;
}
