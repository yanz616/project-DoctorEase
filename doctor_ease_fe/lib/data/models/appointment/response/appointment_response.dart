import 'package:doctor_ease_fe/data/models/appointment/appointment_model.dart';

class AppointmentResponse {
  final String message;
  final AppointmentModel appointmentModel;

  AppointmentResponse({required this.message, required this.appointmentModel});

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
      message: json['message'],
      appointmentModel: AppointmentModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': appointmentModel.toJson()};
  }
}

class CancelAppointmentResponse {
  final String message;

  CancelAppointmentResponse({required this.message});

  factory CancelAppointmentResponse.fromJson(Map<String, dynamic> json) {
    return CancelAppointmentResponse(message: json['message']);
  }

  // Map<String, dynamic> toJson() {
  //   return {'message': message};
  // }
}
