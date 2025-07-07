import 'package:doctor_ease_fe/data/models/user/request/auth_request.dart';

abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final RegisterRequest request;

  RegisterButtonPressed({required this.request});
}
