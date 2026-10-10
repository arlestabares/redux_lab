import 'package:flutter_test/flutter_test.dart';

import 'package:redux_enterprise_lab/features/auth/redux/auth_actions.dart';
import 'package:redux_enterprise_lab/features/counter/redux/app_state.dart';
import 'package:redux_enterprise_lab/features/counter/redux/counter_actions.dart';
import 'package:redux_enterprise_lab/features/dashboard/redux/dashboard_actions.dart';
import 'package:redux_enterprise_lab/redux/root_reducer.dart';

void main() {
  group('rootReducer', () {
    test('increments counter without changing other features', () {
      const initialState = AppState(
        counter: 5,
        isAuthenticated: true,
        dashboardMessage: 'Hola, Arlés',
      );

      final nextState = rootReducer(
        initialState,
        const IncrementCounterAction(),
      );

      expect(nextState.counter, 6);
      expect(nextState.isAuthenticated, true);
      expect(nextState.dashboardMessage, 'Hola, Arlés');
      expect(initialState.counter, 5);
    });

    test('login preserves counter and dashboard message', () {
      const initialState = AppState(
        counter: 8,
        dashboardMessage: 'Estado conservado',
      );

      final nextState = rootReducer(initialState, const LoginAction());

      expect(nextState.isAuthenticated, true);
      expect(nextState.counter, 8);
      expect(nextState.dashboardMessage, 'Estado conservado');
    });

    test('logout preserves unrelated state', () {
      const initialState = AppState(
        counter: 12,
        isAuthenticated: true,
        dashboardMessage: 'Mi dashboard',
      );

      final nextState = rootReducer(initialState, const LogoutAction());

      expect(nextState.isAuthenticated, false);
      expect(nextState.counter, 12);
      expect(nextState.dashboardMessage, 'Mi dashboard');
    });

    test('updates only the dashboard message', () {
      const initialState = AppState(counter: 3, isAuthenticated: true);

      final nextState = rootReducer(
        initialState,
        const UpdateDashboardMessageAction('Nuevo mensaje'),
      );

      expect(nextState.dashboardMessage, 'Nuevo mensaje');
      expect(nextState.counter, 3);
      expect(nextState.isAuthenticated, true);
    });

    test('returns an equivalent state for an unknown action', () {
      const initialState = AppState(
        counter: 4,
        dashboardMessage: 'Sin cambios',
      );

      final nextState = rootReducer(initialState, 'UNKNOWN');

      expect(nextState, initialState);
    });
  });
}
