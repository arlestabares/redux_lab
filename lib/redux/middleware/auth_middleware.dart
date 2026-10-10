import 'dart:async';

import 'package:redux/redux.dart';
import 'package:redux_enterprise_lab/features/counter/redux/app_state.dart';

import '../../features/auth/data/fake_auth_repository.dart';
import '../../features/auth/redux/auth_actions.dart';

Middleware<AppState> createAuthMiddleware(FakeAuthRepository repository) {
  return (store, action, next) {
    /// Permite que Redux procese primero la acción.
    /// Es la instrucción que deja continuar la acción hacia el siguiente middleware y, finalmente, el reducer.
    /// En nuestro caso, el middleware permite que LoginRequestedAction llegue al reducer. A
    /// sí, el estado pasa a loading inmediatamente.
    next(action);
    if (action is LoginRequestedAction) {
      // ¿Qué hace unawaited(...)?
      /// La operación asíncrona se inicia sin obligar a que el callback del middleware espere a que termine.
      /// La función _performLogin se encarga de esperar al repositorio y capturar sus errores.
      /// Cuando el repositorio responde, el middleware despacha una nueva acción de éxito o de error.
      /// Esa nueva acción atraviesa Redux normalmente.
      /// Importante: unawaited no significa ignorar los errores. Por eso capturamos las excepciones
      /// dentro de _performLogin. En una implementación de producción también estudiaríamos cancelación
      /// de operaciones, solicitudes duplicadas y cómo evitar que una respuesta antigua sobrescriba un
      /// estado más reciente.
      unawaited(_performLogin(store, repository, action));
    }
  };
}

Future<void> _performLogin(
  Store<AppState> store,
  FakeAuthRepository repository,
  LoginRequestedAction action,
) async {
  try {
    final username = await repository.login(
      username: action.username,
      password: action.password,
    );
    store.dispatch(LoginSucceededAction(username));
  } catch (error) {
    store.dispatch(
      LoginFailedAction(error.toString().replaceFirst('Exception: ', '')),
    );
  }
}
