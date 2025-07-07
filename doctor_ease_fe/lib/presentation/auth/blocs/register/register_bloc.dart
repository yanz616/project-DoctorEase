import 'package:doctor_ease_fe/data/service/auth_service.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/register/register_event.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService authService;

  RegisterBloc({required this.authService}) : super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading());
      try {
        final response = await authService.register(event.request);
        //token kita simpan di local storage lewat login saja
        // await LocalStorage.setString(response.token);
        emit(RegisterSuccess(response: response));
      } catch (e) {
        emit(RegisterFailure(error: e.toString()));
        // final error = e.toString().toLowerCase();
        // if (error.contains('email already exists')) {
        //   emit(
        //     RegisterFailure(
        //       errorType: RegisterErrorType.emailAlreadyExists,
        //       message: 'Email already exists.',
        //     ),
        //   );
        // } else if (error.contains('name already exists')) {
        //   emit(
        //     RegisterFailure(
        //       errorType: RegisterErrorType.nameAlreadyExists,
        //       message: 'Name already exists.',
        //     ),
        //   );
        // } else if (error.contains('weak password')) {
        //   emit(
        //     RegisterFailure(
        //       errorType: RegisterErrorType.weakPassword,
        //       message: 'Weak password.',
        //     ),
        //   );
        // } else if (error.contains('short password')) {
        //   emit(
        //     RegisterFailure(
        //       errorType: RegisterErrorType.shortPassword,
        //       message: 'Password is too short.',
        //     ),
        //   );
        // } else if (error.contains('invalid email')) {
        //   emit(
        //     RegisterFailure(
        //       errorType: RegisterErrorType.invalidEmail,
        //       message: 'Invalid email format.',
        //     ),
        //   );
        // } else {
        //   emit(
        //     RegisterFailure(
        //       errorType: RegisterErrorType.registerFailed,
        //       message: 'Registration failed. Please try again.',
        //     ),
        //   );
        // }
      }
    });
  }
}
