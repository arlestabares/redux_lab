class FakeAuthRepository {
  Future<String> login({
    required String username,
    required String password,
  }) async {
    // SImula el tiempo de respuesta de un servidor
    await Future.delayed(const Duration(seconds: 2));
    if (username.trim().isEmpty || password != 'redux123') {
      throw Exception('Credenciales incorrectas');
    }

    return username.trim();
  }
}
