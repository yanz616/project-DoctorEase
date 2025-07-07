import 'package:doctor_ease_fe/data/models/user/response/auth_response.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterResponse response;

  RegisterSuccess({required this.response});
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure({required this.error});
}

// enum RegisterErrorType {
//   registerFailed,
//   nameAlreadyExists,
//   emailAlreadyExists,
//   weakPassword,
//   shortPassword,
//   invalidEmail,
// }

// class RegisterFailure extends RegisterState {
//   final RegisterErrorType errorType;
//   final String? message;

//   RegisterFailure({required this.errorType, this.message});
// }
