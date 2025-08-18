import 'package:doctor_ease_fe/data/models/user/request/auth_request.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  LoginRequest request;

  LoginEvent(this.request);
}

class RegisterEvent extends AuthEvent {
  RegisterRequest request;

  RegisterEvent(this.request);
}

class LogoutEvent extends AuthEvent {}
