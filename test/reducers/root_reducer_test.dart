import 'package:flutter_test/flutter_test.dart';

import 'package:redux_enterprise_lab/features/auth/redux/auth_actions.dart';
import 'package:redux_enterprise_lab/features/auth/redux/auth_state.dart';
import 'package:redux_enterprise_lab/features/counter/redux/counter_actions.dart';
import 'package:redux_enterprise_lab/features/dashboard/redux/dashboard_actions.dart';
import 'package:redux_enterprise_lab/redux/app_state.dart';
import 'package:redux_enterprise_lab/redux/root_reducer.dart';

void main() {
  group('rootReducer', () {
    test('increments counter without changing other features', () {
      const initialState = AppState(
        counter: 5,
        auth: AuthState(status: AuthStatus.authenticated),
        dashboardMessage: 'Hola, Arlés',
      );

      final nextState = rootReducer(
        initialState,
        const IncrementCounterAction(),
      );

      expect(nextState.counter, 6);
      expect(nextState.auth, initialState.auth);
      expect(nextState.dashboardMessage, 'Hola, Arlés');
      expect(initialState.counter, 5);
    });

    test('login request changes authentication to loading', () {
      const initialState = AppState(counter: 8);

      final nextState = rootReducer(
        initialState,
        const LoginRequestedAction(
          username: 'arle@example.com',
          password: 'redux123',
        ),
      );

      expect(nextState.auth.status, AuthStatus.loading);
      expect(nextState.counter, 8);
    });

    test('login success authenticates the user', () {
      const initialState = AppState();

      final nextState = rootReducer(
        initialState,
        const LoginSucceededAction('arle@example.com'),
      );

      expect(nextState.auth.status, AuthStatus.authenticated);
      expect(nextState.auth.username, 'arle@example.com');
    });

    test('login failure records the error', () {
      const initialState = AppState();

      final nextState = rootReducer(
        initialState,
        const LoginFailedAction('Credenciales incorrectas'),
      );

      expect(nextState.auth.status, AuthStatus.failure);
      expect(nextState.auth.errorMessage, 'Credenciales incorrectas');
    });

    test('logout preserves unrelated state', () {
      const initialState = AppState(
        counter: 12,
        auth: AuthState(status: AuthStatus.authenticated),
        dashboardMessage: 'Mi dashboard',
      );

      final nextState = rootReducer(initialState, const LogoutAction());

      expect(nextState.auth.status, AuthStatus.unauthenticated);
      expect(nextState.counter, 12);
      expect(nextState.dashboardMessage, 'Mi dashboard');
    });

    test('updates only the dashboard message', () {
      const initialState = AppState(
        counter: 3,
        auth: AuthState(status: AuthStatus.authenticated),
      );

      final nextState = rootReducer(
        initialState,
        const UpdateDashboardMessageAction('Nuevo mensaje'),
      );

      expect(nextState.dashboardMessage, 'Nuevo mensaje');
      expect(nextState.counter, 3);
      expect(nextState.auth.status, AuthStatus.authenticated);
    });

    test('preserves an equivalent state for an unknown action', () {
      const initialState = AppState(
        counter: 4,
        dashboardMessage: 'Sin cambios',
      );

      final nextState = rootReducer(initialState, 'UNKNOWN');

      expect(nextState, initialState);
    });
  });
}
