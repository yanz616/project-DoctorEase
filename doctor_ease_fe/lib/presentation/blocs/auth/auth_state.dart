import 'package:doctor_ease_fe/data/models/user/response/auth_response.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class AuthSuccessState extends AuthState {
  AuthResponse response;

  AuthSuccessState({required this.response});
}

class LogoutSuccessState extends AuthState {
  LogoutResponse response;

  LogoutSuccessState({required this.response});
}

class FailureAuthState extends AuthState {
  final String error;

  FailureAuthState({required this.error});
}
