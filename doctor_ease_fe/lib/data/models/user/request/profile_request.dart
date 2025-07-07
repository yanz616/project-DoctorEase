class UpdateProfileRequest {
  final String name;
  final String email;
  final String? avatar;
  final String? password;
  final String? passwordConfirmation;

  UpdateProfileRequest({
    required this.name,
    required this.email,
    this.avatar,
    this.password,
    this.passwordConfirmation,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    return UpdateProfileRequest(
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatar': avatar,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
