import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/constants/variabel.dart';
import '../models/doctor_model.dart';

class DoctorService {
  final String baseUrl = Variabel.baseUrl;

  Future<List<Doctor>> getDoctors() async {
    final response = await http.get(Uri.parse('$baseUrl/api/doctors'));

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((e) => Doctor.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }
}
