import '../features/auth/redux/auth_reducer.dart';
import '../features/counter/redux/app_state.dart';
import '../features/counter/redux/counter_reducer.dart';
import '../features/dashboard/redux/dashboard_reducer.dart';

///
/// ¡Aquí está el corazón de la nueva arquitectura!
/// Cuando el Store recibe una acción, el reducer raíz se encarga de pasarla a los reducers de las distintas funcionalidades.
/// Cada reducer recibe únicamente la parte del estado que le corresponde y devuelve su nuevo valor.
/// Por ejemplo, al recibir LoginAction:
/// counterReducer conserva el contador.
/// authReducer devuelve true.
/// dashboardReducer conserva el mensaje.
/// El resultado es un nuevo AppState que reúne los valores actualizados.
///
AppState rootReducer(AppState state, dynamic action) {
  return AppState(
    counter: counterReducer(state.counter, action),
    isAuthenticated: authReducer(state.isAuthenticated, action),
    dashboardMessage: dashboardReducer(state.dashboardMessage, action),
  );
}
