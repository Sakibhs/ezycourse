import 'dart:developer';

import 'package:ezycourse/core/constants/string_constant.dart';
import 'package:ezycourse/data/local/shared_prefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LogoutRequested>(_onLogoutRequested);
    on<LoginButtonPressed>(_onLogin);
  }

  void _onLogin(LoginButtonPressed event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    try {
      String token = await authRepository.login(event.email, event.password);
      SharedPrefs.setString(StringConstants.token, token);
      emit(LoginInitial());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(LogoutInProgress());
    try {
      final success = await authRepository.logout();
      if (success) {
        SharedPrefs.setString(StringConstants.token, "");
        emit(LogoutSuccess());
      } else {
        emit(LogoutFailure("Logout failed."));
      }
    } catch (e) {
      emit(LogoutFailure("Error: ${e.toString()}"));
    }
  }

}
