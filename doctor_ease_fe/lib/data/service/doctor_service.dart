import 'package:doctor_ease_fe/core/utils/local_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/constants/variabel.dart';
import '../models/doctor/doctor_model.dart';

class DoctorService {
  final String baseUrl = Variabel.baseUrl;

  Future<List<Doctor>> getDoctors() async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception("Token Not Found");
    final response = await http.get(
      Uri.parse('$baseUrl/doctors'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'appliifcation/json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Doctor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  Future<DoctorSpecial> getDoctorBySpecialization(int id) async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception("Token Not Found");
    final response = await http.get(
      Uri.parse('$baseUrl/doctors/specialization/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DoctorSpecial.fromJson(data);
    } else {
      throw Exception('Failed to load doctors');
    }
  }
}
