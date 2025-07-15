import 'dart:convert';

import 'package:doctor_ease_fe/core/constants/variabel.dart';
import 'package:doctor_ease_fe/core/utils/local_storage.dart';
import 'package:doctor_ease_fe/data/models/appointment/appointment_model.dart';
import 'package:doctor_ease_fe/data/models/appointment/request/appointment_request.dart';
import 'package:doctor_ease_fe/data/models/appointment/response/appointment_response.dart';
import 'package:http/http.dart' as http;

class AppointmentService {
  final String baseUrl = Variabel.baseUrl;

  // Create appointment
  Future<AppointmentResponse> appointment(AppointmentRequest request) async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception('Token not found');

    final response = await http.post(
      Uri.parse('$baseUrl/appointments'),
      body: json.encode(request.toJson()),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      print(data);
      return AppointmentResponse.fromJson(data);
    } else {
      throw Exception('Failed to Create Appointment');
    }
  }

  // Update appointment milik user sendiri
  Future<AppointmentResponse> updateAppointment(
    int id,
    AppointmentRequest request,
  ) async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception('Token not found');
    final response = await http.put(
      Uri.parse('$baseUrl/appointments/$id'),
      body: json.encode(request.toJson()),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      return AppointmentResponse.fromJson(data);
    } else {
      throw Exception('Failed to Update Appointment');
    }
  }

  //get appointment
  Future<List<AppointmentModel>> getAppointment() async {
    final token = await LocalStorage.getString();
    if (token == null) throw ("Token Not Found");
    final response = await http.get(
      Uri.parse("$baseUrl/appointments"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((json) => AppointmentModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to Load Appintment");
    }
  }

  // Delete appointment milik user sendiri
  Future<CancelAppointmentResponse> deleteAppointment(int id) async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception('Token not found');
    final response = await http.delete(
      Uri.parse('$baseUrl/appointments/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      return CancelAppointmentResponse.fromJson(data);
    } else {
      throw Exception('Failed to Delete Appointment');
    }
  }
}
