import 'package:doctor_ease_fe/data/models/user/response/profile_response.dart';

abstract class UpdateState {}

class UpdateInitialState extends UpdateState {}

class UpdateLoadingState extends UpdateState {}

class UpdateLoadedState extends UpdateState {
  final UpdateProfileResponse response;

  UpdateLoadedState({required this.response});
}

class UpdateErrorState extends UpdateState {
  final String error;

  UpdateErrorState({required this.error});
}
