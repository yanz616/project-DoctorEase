import 'dart:convert';

import 'package:doctor_ease_fe/core/constants/variabel.dart';
import 'package:doctor_ease_fe/core/utils/local_storage.dart';
import 'package:doctor_ease_fe/data/models/user/request/profile_request.dart';
import 'package:doctor_ease_fe/data/models/user/response/profile_response.dart';
import 'package:doctor_ease_fe/data/models/user/user_model.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  final String baseUrl = Variabel.baseUrl;

  Future<User> me() async {
    // Ambil token dari local storage
    // Misal setelah login sukses
    final token = await LocalStorage.getString();
    if (token == null) throw Exception('Token not found');
    final response = await http.get(
      Uri.parse("$baseUrl/me"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print(data);
      return User.fromJson(data);
    } else {
      print(response.body);
      throw Exception('Failed to fetch user data');
    }
  }

  // Update user profile
  // Request berisi model UpdateProfileRequest
  // UpdateProfileRequest berisi data yang diperlukan untuk update profile, misalnya nama, email, dll
  // Jika gagal, akan mengembalikan error
  // Response berisi model UpdateProfileResponse
  // Jika sukses, akan mengembalikan UpdateProfileResponse
  Future<UpdateProfileResponse> updateProfile(
    UpdateProfileRequest request,
  ) async {
    final token = await LocalStorage.getString();
    if (token == null) throw Exception('Token not found');
    final response = await http.put(
      Uri.parse("$baseUrl/profile"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Response berisi model User dan message dari backend
      // print(data);
      return UpdateProfileResponse.fromJson(data);
    } else {
      print(response.body);
      throw Exception('Failed to update profile');
    }
  }
}
