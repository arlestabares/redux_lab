import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_enterprise_lab/app/redux_enterprise_lab_app.dart';
import 'package:redux_enterprise_lab/features/counter/redux/app_state.dart';
import 'package:redux_enterprise_lab/features/counter/redux/store_factory.dart';

import 'core/di/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  final store = createAppStore();
  runApp(
    StoreProvider<AppState>(store: store, child: const ReduxEnterpriseLabApp()),
  );
}
