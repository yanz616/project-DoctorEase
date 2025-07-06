class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String? avatar;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    this.avatar,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'avatar': avatar,
    };
  }
}
