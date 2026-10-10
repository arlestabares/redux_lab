import 'package:redux/redux.dart';
import 'package:redux_enterprise_lab/features/counter/redux/app_state.dart';
import 'package:redux_enterprise_lab/redux/root_reducer.dart';

///
/// Antes utilizábamos [Store<int>]. Ahora utilizamos [Store<AppState>].
/// Esta diferencia es fundamental: el Store administra el árbol de estado completo, no solamente el contador.

Store<AppState> createAppStore() {
  return Store<AppState>(rootReducer, initialState: const AppState());
}
