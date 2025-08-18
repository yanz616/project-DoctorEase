import 'package:doctor_ease_fe/data/models/user/response/auth_response.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccessResponse extends AuthState {
  final AuthResponse response;

  AuthSuccessResponse(this.response);
}

class LogoutSuccess extends AuthState {
  final LogoutResponse response;

  LogoutSuccess(this.response);
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}
