import 'package:doctor_ease_fe/data/models/user/response/auth_response.dart';

abstract class LoginState {}

//inisialisasi state login atau awalan
class LoginInitial extends LoginState {}

//state ketika proses login sedang berlangsung, biasanya digunakan untuk menampilkan loading spinner atau indikator lainnya
class LoginLoading extends LoginState {}

//login berhasil
//response berisi data yang diterima dari server setelah login berhasil
class LoginSuccess extends LoginState {
  final LoginResponse response;

  LoginSuccess({required this.response});
}

//login gagal
//error berisi pesan kesalahan yang diterima dari server atau dari proses login
class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}
