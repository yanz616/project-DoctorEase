import 'dart:convert';

import 'package:doctor_ease_fe/core/constants/variabel.dart';
import 'package:doctor_ease_fe/core/utils/local_storage.dart';
import 'package:doctor_ease_fe/data/models/specialization/specialization_model.dart';
import 'package:http/http.dart' as http;

class SpecializationRepository {
  final baseUrl = Variabel.baseUrl;

  Future<List<Specialization>> specializations() async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception("Token Not Found");
    final response = await http.get(
      Uri.parse('$baseUrl/specialization'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((json) => Specialization.fromJson(json)).toList();
    } else {
      throw Exception('Specialization Not Found: ${response.statusCode}');
    }
  }
}
