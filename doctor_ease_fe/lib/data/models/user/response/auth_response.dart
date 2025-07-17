import 'package:doctor_ease_fe/data/models/user/user_model.dart';

class AuthResponse {
  final String message;
  final String token;
  final User user;

  AuthResponse({
    required this.message,
    required this.token,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message'],
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'token': token, 'user': user.toJson()};
  }
}

class LogoutResponse {
  final String message;

  LogoutResponse({required this.message});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
