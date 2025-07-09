import 'package:doctor_ease_fe/core/utils/local_storage.dart';
import 'package:doctor_ease_fe/data/service/auth_service.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/login/login_event.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//bloc untuk menangani login
//bloc ini akan menerima event LoginButtonPressed dari UI
//dan mengirimkan state LoginLoading, LoginSuccess, atau LoginFailure
//ke UI tergantung pada hasil dari proses login
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  //constructor untuk inisialisasi bloc
  //menerima AuthService sebagai dependency injection
  LoginBloc({required this.authService}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      //emit state LoginLoading sebelum memulai proses login
      emit(LoginLoading());
      try {
        //memanggil service login dengan request yang diberikan
        //dan menunggu response dari server
        final response = await authService.login(event.request);
        //jika login berhasil, simpan token ke local storage
        await LocalStorage.setString(response.token);
        //dan emit state LoginSuccess dengan response yang didapat
        emit(LoginSuccess(response: response));
      } catch (e) {
        //jika terjadi error, emit state LoginFailure dengan pesan error
        //pesan error ini akan ditampilkan di UI
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
