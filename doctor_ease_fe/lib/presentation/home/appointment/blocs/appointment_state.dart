import 'package:doctor_ease_fe/data/models/appointment/appointment_model.dart';
import 'package:doctor_ease_fe/data/models/appointment/response/appointment_response.dart';

abstract class AppointmentState {}

//inisialisai state
class InitialAppointments extends AppointmentState {}

//loading state
class LoadingAppointment extends AppointmentState {}

//mengambil data appointment setelah di load
class LoadedAppointments extends AppointmentState {
  final List<AppointmentModel> appointment;

  LoadedAppointments(this.appointment);
}

class SuccesAppointment extends AppointmentState {
  final AppointmentResponse response;

  SuccesAppointment(this.response);
}

class SuccesDeleteAppointment extends AppointmentState {
  final CancelAppointmentResponse response;

  SuccesDeleteAppointment(this.response);
}

// class Succes

class FailureAppointment extends AppointmentState {
  final String error;

  FailureAppointment(this.error);
}
