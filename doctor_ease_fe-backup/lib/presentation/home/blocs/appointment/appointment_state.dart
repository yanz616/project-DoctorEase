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

//succes add or update
class SuccessAppointment extends AppointmentState {
  final AppointmentResponse response;

  SuccessAppointment(this.response);
}

//succes delete
class SuccessDeleteAppointment extends AppointmentState {
  final CancelAppointmentResponse response;

  SuccessDeleteAppointment(this.response);
}

//kondisi eror
class FailureAppointment extends AppointmentState {
  final String error;

  FailureAppointment(this.error);
}
