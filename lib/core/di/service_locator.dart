import 'package:get_it/get_it.dart';

import '../../features/auth/data/fake_auth_repository.dart';

final GetIt sl = GetIt.instance;

void setupDependencies() {
  sl.registerLazySingleton<FakeAuthRepository>(() => FakeAuthRepository());
}
