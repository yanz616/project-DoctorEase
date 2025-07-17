import 'package:doctor_ease_fe/data/models/user/response/profile_response.dart';
import 'package:doctor_ease_fe/data/models/user/user_model.dart';

abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class GetMeLoaded extends ProfileState {
  final User user;

  GetMeLoaded(this.user);
}

class UpdatedProfile extends ProfileState {
  final UpdateProfileResponse response;

  UpdatedProfile(this.response);
}

class FailureProfileState extends ProfileState {
  final String error;

  FailureProfileState(this.error);
}
