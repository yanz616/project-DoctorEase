import 'package:doctor_ease_fe/data/models/appointment/request/appointment_request.dart';

abstract class AppointmentEvent {}

//load appointment
class LoadAppointments extends AppointmentEvent {}

//crate appoinment
class CreateAppoinments extends AppointmentEvent {
  final AppointmentRequest request;

  CreateAppoinments({required this.request});
}

//update Appointment
class UpdateAppointment extends AppointmentEvent {
  final int id;
  final AppointmentRequest request;

  UpdateAppointment({required this.id, required this.request});
}

//delete Appointment
class DeleteAppointment extends AppointmentEvent {
  final int id;

  DeleteAppointment({required this.id});
}
