import 'package:doctor_ease_fe/data/models/user/user_model.dart';

class UpdateProfileResponse {
  final String message;
  final User user;

  UpdateProfileResponse({required this.message, required this.user});

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      message: json['message'],
      user: User.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': user.toJson()};
  }
}
