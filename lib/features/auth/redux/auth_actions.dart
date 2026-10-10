class LoginAction {
  const LoginAction();
}

class LogoutAction {
  const LogoutAction();
}

class LoginRequestedAction {
  final String username;
  final String password;

  const LoginRequestedAction({required this.username, required this.password});
}

class LoginSucceededAction {
  final String username;

  const LoginSucceededAction(this.username);
}

class LoginFailedAction {
  final String message;

  const LoginFailedAction(this.message);
}
