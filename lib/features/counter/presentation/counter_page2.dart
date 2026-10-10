import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../auth/redux/auth_actions.dart';
import '../../counter/redux/counter_actions.dart';
import '../../dashboard/redux/dashboard_actions.dart';
import '../redux/app_state.dart';

class CounterPage2 extends StatelessWidget {
  const CounterPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redux Enterprise Lab')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'CONTADOR',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              StoreConnector<AppState, int>(
                distinct: true,
                converter: (store) => store.state.counter,
                builder: (context, count) {
                  return Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                children: [
                  IconButton.filled(
                    tooltip: 'Decrementar',
                    onPressed: () {
                      StoreProvider.of<AppState>(context)
                          .dispatch(const DecrementCounterAction());
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  IconButton.filled(
                    tooltip: 'Incrementar',
                    onPressed: () {
                      StoreProvider.of<AppState>(context)
                          .dispatch(const IncrementCounterAction());
                    },
                    icon: const Icon(Icons.add),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      StoreProvider.of<AppState>(context)
                          .dispatch(const ResetCounterAction());
                    },
                    child: const Text('Reiniciar'),
                  ),
                ],
              ),
              const Divider(height: 40),
              const Text(
                'AUTENTICACIÓN SIMULADA',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              StoreConnector<AppState, bool>(
                distinct: true,
                converter: (store) => store.state.isAuthenticated,
                builder: (context, isAuthenticated) {
                  return Column(
                    children: [
                      Text(
                        isAuthenticated ? 'Sesión iniciada' : 'Sesión cerrada',
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          StoreProvider.of<AppState>(context).dispatch(
                            isAuthenticated
                                ? const LogoutAction()
                                : const LoginAction(),
                          );
                        },
                        child: Text(
                          isAuthenticated ? 'Cerrar sesión' : 'Iniciar sesión',
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Divider(height: 40),
              const Text(
                'DASHBOARD',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              StoreConnector<AppState, String>(
                distinct: true,
                converter: (store) => store.state.dashboardMessage,
                builder: (context, message) {
                  return Text(message, textAlign: TextAlign.center);
                },
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  StoreProvider.of<AppState>(context).dispatch(
                    const UpdateDashboardMessageAction(
                      '¡Estado actualizado desde el Dashboard!',
                    ),
                  );
                },
                child: const Text('Actualizar mensaje'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
