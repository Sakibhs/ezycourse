abstract class AuthState {}

class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final String username;

  LoginSuccess(this.username);
}

class LoginFailure extends AuthState {
  final String error;

  LoginFailure(this.error);
}

class AuthInitial extends AuthState {}

class LogoutInProgress extends AuthState {}

class LogoutSuccess extends AuthState {}

class LogoutFailure extends AuthState {
  final String message;
  LogoutFailure(this.message);
}
