import 'package:doctor_ease_fe/core/utils/local_storage.dart';
import 'package:doctor_ease_fe/data/repositories/auth_repository.dart';
import 'package:doctor_ease_fe/presentation/blocs/auth/auth_event.dart';
import 'package:doctor_ease_fe/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(InitialAuthState()) {
    on<LoginEvent>((event, emit) async {
      emit(LoadingAuthState());
      try {
        final response = await authRepository.login(event.request);
        await LocalStorage.setString(response.token);
        emit(AuthSuccessState(response));
      } catch (e) {
        emit(FailureAuthState(e.toString()));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(LoadingAuthState());
      try {
        final response = await authRepository.register(event.request);
        await LocalStorage.setString(response.token);
        emit(AuthSuccessState(response));
      } catch (e) {
        emit(FailureAuthState(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(LoadingAuthState());
      try {
        Future.delayed(Duration(seconds: 2));
        final response = await authRepository.logout();
        await LocalStorage.removeString();
        emit(LogoutSuccessState(response));
      } catch (e) {
        emit(FailureAuthState(e.toString()));
      }
    });
  }
}
