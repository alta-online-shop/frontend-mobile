part of './auth_service.dart';

class Login {
  final String email;
  final String password;

  Login({
    required this.email,
    required this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    String? email;
    String? password;
    if (json["email"] is String) email = json["email"];
    if (json["password"] is String) password = json["password"];

    return Login(email: email ?? '', password: password ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["email"] = email;
    data["password"] = password;
    return data;
  }
}

class Register {
  final String fullname;
  final String email;
  final String password;

  Register({
    required this.fullname,
    required this.email,
    required this.password,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      fullname: json["fullname"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["fullname"] = fullname;
    data["email"] = email;
    data["password"] = password;
    return data;
  }
}
