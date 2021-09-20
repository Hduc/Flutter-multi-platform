import 'dart:convert';

class LoginModel {
  LoginModel(
      {required this.email,
      required this.lastName,
      this.firstName,
      this.statusLogin,
      this.token});
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      email: json['email'] as String,
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String?,
      statusLogin: json['statusLogin'] as int?,
      token: json['token'] as String?);

  String email;
  String lastName;
  String? firstName;
  int? statusLogin;
  String? token;
}

LoginModel loginModelFromJson(String jsonData) {
  final data = json.decode(jsonData) as Map<String, dynamic>;
  return LoginModel.fromJson(data);
}

List<LoginModel> loginModelsFromJson(String jsonData) {
  final data = json.decode(jsonData) as List;
  return data
      .map((dynamic item) => LoginModel.fromJson(item as Map<String, dynamic>))
      .toList();
}
