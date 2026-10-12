import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:redux_enterprise_lab/features/auth/data/fake_auth_repository.dart';
import 'package:redux_enterprise_lab/features/auth/redux/auth_actions.dart';
import 'package:redux_enterprise_lab/features/auth/redux/auth_state.dart';
import 'package:redux_enterprise_lab/redux/app_state.dart';
import 'package:redux_enterprise_lab/redux/middleware/auth_middleware.dart';
import 'package:redux_enterprise_lab/redux/root_reducer.dart';

class ControlledAuthRepository extends FakeAuthRepository {
  final Completer<String> completer = Completer<String>();

  @override
  Future<String> login({required String username, required String password}) {
    return completer.future;
  }
}

void main() {
  group('Auth middleware', () {
    late ControlledAuthRepository repository;
    late Store<AppState> store;

    setUp(() {
      repository = ControlledAuthRepository();

      store = Store<AppState>(
        rootReducer,
        initialState: const AppState(),
        middleware: [createAuthMiddleware(repository)],
      );
    });

    test('establece loading mientras espera la respuesta', () {
      store.dispatch(
        const LoginRequestedAction(
          username: 'arles@example.com',
          password: 'redux123',
        ),
      );

      expect(store.state.auth.status, AuthStatus.loading);

      expect(repository.completer.isCompleted, isFalse);
    });

    test('autentica al usuario cuando el login tiene éxito', () async {
      store.dispatch(
        const LoginRequestedAction(
          username: 'arle@example.com',
          password: 'redux123',
        ),
      );

      final result = store.onChange.firstWhere(
        (state) => state.auth.status == AuthStatus.authenticated,
      );

      repository.completer.complete('arles@example.com');

      final newState = await result;

      expect(newState.auth.status, AuthStatus.authenticated);

      expect(newState.auth.username, 'arles@example.com');
    });

    test('establece failure cuando el login falla', () async {
      store.dispatch(
        const LoginRequestedAction(
          username: 'arle@example.com',
          password: 'incorrecta',
        ),
      );

      final result = store.onChange.firstWhere(
        (state) => state.auth.status == AuthStatus.failure,
      );

      repository.completer.completeError(Exception('Credenciales incorrectas'));

      final newState = await result;

      expect(newState.auth.status, AuthStatus.failure);

      expect(newState.auth.errorMessage, 'Credenciales incorrectas');
    });
  });
}
