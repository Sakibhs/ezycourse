abstract class AuthEvent {}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressed(this.email, this.password);
}

class LogoutRequested extends AuthEvent {}