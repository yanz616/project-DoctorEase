import 'package:doctor_ease_fe/data/models/user/auth_request.dart';

abstract class LoginEvent {}

//event akan dikirimkan dari UI ke bloc
//untuk memberitahu bloc bahwa ada aksi yang terjadi
class LoginButtonPressed extends LoginEvent {
  final LoginRequest request;
  //request berisi data yang diperlukan untuk login misalnya email dan password

  LoginButtonPressed({required this.request});
}
