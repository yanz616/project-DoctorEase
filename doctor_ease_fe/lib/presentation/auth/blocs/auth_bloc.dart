import 'package:doctor_ease_fe/core/utils/local_storage.dart';
import 'package:doctor_ease_fe/data/service/auth_service.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_event.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//bloc untuk menangani login
//bloc ini akan menerima event LoginButtonPressed dari UI
//dan mengirimkan state LoginLoading, LoginSuccess, atau LoginFailure
//ke UI tergantung pada hasil dari proses login
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  //constructor untuk inisialisasi bloc
  //menerima AuthService sebagai dependency injection
  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      //emit state LoginLoading sebelum memulai proses login
      emit(AuthLoading());
      try {
        //memanggil service login dengan request yang diberikan
        //dan menunggu response dari server
        final response = await authService.login(event.request);
        //jika login berhasil, simpan token ke local storage
        await LocalStorage.setString(response.token);
        //dan emit state LoginSuccess dengan response yang didapat
        emit(AuthSuccessResponse(response));
      } catch (e) {
        //jika terjadi error, emit state LoginFailure dengan pesan error
        //pesan error ini akan ditampilkan di UI
        emit(AuthFailure(error: e.toString()));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await authService.register(event.request);
        await LocalStorage.setString(response.token);
        emit(AuthSuccessResponse(response));
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await Future.delayed(Duration(seconds: 2));
        final response = await authService.logout();
        emit(LogoutSuccess(response));
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
  }
}
