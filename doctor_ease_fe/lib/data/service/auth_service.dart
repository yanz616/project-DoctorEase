import 'dart:convert';

import 'package:doctor_ease_fe/core/constants/variabel.dart';
import 'package:doctor_ease_fe/core/utils/local_storage.dart';
import 'package:doctor_ease_fe/data/models/user/request/auth_request.dart';
import 'package:doctor_ease_fe/data/models/user/response/auth_response.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = Variabel.baseUrl;

  //request untuk login
  // request berisi model LoginRequest
  // login request berisi data yang diperlukan untuk login, misalnya email dan password
  // response berisi model LoginResponse
  // jika sukses, akan mengembalikan LoginResponse
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return LoginResponse.fromJson(data);
    } else {
      print(response.body);
      throw Exception('Failed to login');
    }
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return RegisterResponse.fromJson(data);
    } else {
      print(response.body);
      print('$baseUrl/register');
      throw Exception('Failed to register');
    }
  }

  Future<String> logout() async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception('Token not found');
    final response = await http.post(
      Uri.parse("$baseUrl/logout"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      await LocalStorage.removeString();
      return LogoutResponse.fromJson(data).message;
    } else {
      print(response.body);
      throw Exception('Failed to logout');
    }
  }
}
