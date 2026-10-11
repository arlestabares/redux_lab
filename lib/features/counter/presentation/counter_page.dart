import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../auth/redux/auth_actions.dart';
import '../../auth/redux/auth_state.dart';
import '../../counter/redux/counter_actions.dart';
import '../../dashboard/redux/dashboard_actions.dart';
import '../redux/app_state.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final _usernameController = TextEditingController(text: 'arles@example.com');

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                style: TextStyle(fontWeight: FontWeight.bold),
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
                'AUTENTICACIÓN ASÍNCRONA',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario o correo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña de prueba',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              StoreConnector<AppState, AuthState>(
                distinct: true,
                converter: (store) => store.state.auth,
                builder: (context, auth) {
                  if (auth.status == AuthStatus.loading) {
                    return const Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 8),
                        Text('Iniciando sesión...'),
                      ],
                    );
                  }

                  if (auth.status == AuthStatus.authenticated) {
                    return Column(
                      children: [
                        Text('¡Bienvenido, ${auth.username}!'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            StoreProvider.of<AppState>(context)
                                .dispatch(const LogoutAction());
                          },
                          child: const Text('Cerrar sesión'),
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      if (auth.status == AuthStatus.failure)
                        Text(
                          auth.errorMessage ?? 'Error desconocido',
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          StoreProvider.of<AppState>(context).dispatch(
                            LoginRequestedAction(
                              username: _usernameController.text,
                              password: _passwordController.text,
                            ),
                          );
                        },
                        child: const Text('Iniciar sesión'),
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
