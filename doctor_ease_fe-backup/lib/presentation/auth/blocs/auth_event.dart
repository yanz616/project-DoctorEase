import 'package:doctor_ease_fe/data/models/user/request/auth_request.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LoginRequest request;

  LoginEvent({required this.request});
}

class RegisterEvent extends AuthEvent {
  final RegisterRequest request;

  RegisterEvent({required this.request});
}

class LogoutEvent extends AuthEvent {}
