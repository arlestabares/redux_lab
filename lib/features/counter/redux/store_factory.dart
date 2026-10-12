import 'package:redux/redux.dart';
import 'package:redux_enterprise_lab/redux/middleware/auth_middleware.dart';
import 'package:redux_enterprise_lab/redux/root_reducer.dart';

import '../../../core/di/service_locator.dart';
import '../../../redux/app_state.dart';
import '../../auth/data/fake_auth_repository.dart';

/// Compone el Store y sus middleware.
/// Antes utilizábamos [Store<int>]. Ahora utilizamos [Store<AppState>].
/// Esta diferencia es fundamental: el Store administra el árbol de estado completo, no solamente el contador.

Store<AppState> createAppStore() {
  final repository = sl<FakeAuthRepository>();
  return Store<AppState>(
    rootReducer,
    initialState: const AppState(),

    /// Aquí tenemos una decisión importante: el Store recibe una lista de middleware y nosotros inyectamos
    /// el repositorio en el middleware.
    /// El middleware no necesita crear su propio repositorio ni buscarlo globalmente.
    /// Recibe la dependencia que necesita.
    /// De momento lo creamos directamente en la fábrica. Cuando llegue el módulo de GetIt,
    /// separaremos el registro de dependencias de la construcción del Store.
    middleware: [createAuthMiddleware(repository)],
  );
}
