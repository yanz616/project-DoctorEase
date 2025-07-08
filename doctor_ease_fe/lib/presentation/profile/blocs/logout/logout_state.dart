import 'package:doctor_ease_fe/data/models/user/response/auth_response.dart';

abstract class LogoutState {}

class LogoutInitialState extends LogoutState {}

class LogoutLoadingState extends LogoutState {}

class LogoutSuccessState extends LogoutState {
  final LogoutResponse message;

  LogoutSuccessState({required this.message});
}

class LogoutErrorState extends LogoutState {
  final String error;

  LogoutErrorState({required this.error});
}
