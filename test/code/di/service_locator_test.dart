import 'package:flutter_test/flutter_test.dart';
import 'package:redux_enterprise_lab/core/di/service_locator.dart';
import 'package:redux_enterprise_lab/features/auth/data/fake_auth_repository.dart';

void main() {
  setUp(() async {
    await sl.reset();
    setupDependencies();
  });

  tearDown(() async {
    await sl.reset();
  });

  group('Service Locator', () {
    test('registra FakeAuthRepository', () {
      expect(sl.isRegistered<FakeAuthRepository>(), isTrue);
    });

    test('devuelve la misma instancia del repositorio', () {
      final first = sl<FakeAuthRepository>();
      final second = sl<FakeAuthRepository>();

      expect(identical(first, second), isTrue);
    });

    test('permite obtener el repositorio registrado', () {
      final repository = sl<FakeAuthRepository>();

      expect(repository, isA<FakeAuthRepository>());
    });
  });
}
