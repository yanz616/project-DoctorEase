import 'package:doctor_ease_fe/data/models/user/request/profile_request.dart';

abstract class ProfileEvent {}

class GetMeEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final UpdateProfileRequest request;

  UpdateProfileEvent({required this.request});
}
