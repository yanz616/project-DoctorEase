import 'dart:convert';

import 'package:doctor_ease_fe/core/constants/variabel.dart';
import 'package:doctor_ease_fe/core/utils/local_storage.dart';
import 'package:doctor_ease_fe/data/models/user/response/auth_response.dart';
import '../models/user/request/auth_request.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final baseUrl = Variabel.baseUrl;

  Future<AuthResponse> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      // print(data);
      return AuthResponse.fromJson(data);
    } else {
      throw Exception('Failed to Login');
    }
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return AuthResponse.fromJson(data);
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<LogoutResponse> logout() async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception('Token Not Found');
    final response = await http.post(
      Uri.parse("$baseUrl/logout"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return LogoutResponse.fromJson(data);
    } else {
      throw Exception('Failed to Logout');
    }
  }
}
