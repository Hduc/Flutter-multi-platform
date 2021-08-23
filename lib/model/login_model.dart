import 'dart:convert';

class LoginModel {
  LoginModel({required this.username, required this.password});
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        username: json['username'] as String,
        password: json['password'] as String,
      );

  String username;
  String password;

  // Map<String, dynamic> toJson() =>
  //     <String, dynamic>{'username': username, 'password': password};
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

// String loginModelToJson(LoginModel data) {
//   final jsonData = data.toJson();
//   return json.encode(jsonData);
// }
