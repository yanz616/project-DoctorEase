import 'package:doctor_ease_fe/data/models/user/response/auth_response.dart';
import 'package:doctor_ease_fe/data/service/auth_service.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/logout/logout_event.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/logout/logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthService authService;

  LogoutBloc({required this.authService}) : super(LogoutInitialState()) {
    on<LogoutSubmitted>((event, emit) async {
      emit(LogoutLoadingState());
      try {
        // Simulate a logout process
        await Future.delayed(Duration(seconds: 2));
        final message = await authService.logout();
        emit(LogoutSuccessState(message: LogoutResponse(message: message)));
      } catch (e) {
        emit(LogoutErrorState(error: e.toString()));
      }
    });
  }
}
