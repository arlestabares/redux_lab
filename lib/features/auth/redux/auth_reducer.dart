import 'auth_actions.dart';

bool authReducer(bool state, dynamic action) {
  if (action is LoginAction) {
    return true;
  }

  if (action is LogoutAction) {
    return false;
  }

  return state;
}
