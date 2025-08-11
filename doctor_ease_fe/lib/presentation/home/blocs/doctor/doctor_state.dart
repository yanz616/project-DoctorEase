import 'package:doctor_ease_fe/data/models/doctor/doctor_model.dart';

abstract class DoctorState {}

class DoctorInitialState extends DoctorState {}

class DoctorLoadingState extends DoctorState {}

class DoctorLoadedState extends DoctorState {
  final List<Doctor> doctors;

  DoctorLoadedState({required this.doctors});
}

class DoctorSpecialLoadedState extends DoctorState {
  final DoctorSpecial response;

  DoctorSpecialLoadedState(this.response);
}

class DoctorErrorState extends DoctorState {
  final String error;

  DoctorErrorState({required this.error});
}
