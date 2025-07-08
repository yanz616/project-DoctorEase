abstract class DoctorState {}

class DoctorInitialState extends DoctorState {}

class DoctorLoadingState extends DoctorState {}

class DoctorLoadedState extends DoctorState {
  final List<dynamic> doctors;

  DoctorLoadedState(this.doctors);
}

class DoctorErrorState extends DoctorState {
  final String message;

  DoctorErrorState(this.message);
}
