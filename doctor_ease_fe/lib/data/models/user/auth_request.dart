class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  // factory LoginRequest.fromJson(Map<String, dynamic> json) {
  //   return LoginRequest(email: json['email'], password: json['password']);
  // }
}

class RegisterRequest {
  final String name;
  final String email;
  final String? avatar;
  final String password;
  final String passwordConfirmation;

  RegisterRequest({
    required this.name,
    required this.email,
    this.avatar,
    required this.password,
    required this.passwordConfirmation,
  });

  // factory RegisterRequest.fromJson(Map<String, dynamic> json) {
  //   return RegisterRequest(
  //     name: json['name'],
  //     email: json['email'],
  //     avatar: json['avatar'],
  //     password: json['password'],
  //     passwordConfirmation: json['password_confirmation'],
  //   );
  // }

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
