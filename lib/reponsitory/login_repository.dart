//import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:severingthing/client/login_client.dart';
import 'package:severingthing/model/login_model.dart';
import 'package:severingthing/res/strings/strings.dart';

class LoginRepository {
  final _client = LoginClient();

  Future<List<LoginModel>> authenticates(
      String userName, String password) async {
    final url =
        '${AppStrings.baseUrl}/users/test?userName=$userName&password=$password';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return loginModelsFromJson(response.body);
    } else {
      print('Get Api Authenticate False');
      throw Exception('Failed to load authenticate');
    }
  }

  Future<LoginModel> authenticate(String userName, String password) async {
    final url =
        '${AppStrings.baseUrl}/users/test1?userName=$userName&password=$password';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return loginModelFromJson(response.body);
    } else {
      print('Get Api Authenticate False');
      throw Exception('Failed to load authenticate');
    }
  }

  Future<LoginModel?> sendData(String userName, String password) async {
    final url = '${AppStrings.baseUrl}/users/authenticate';

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'username': userName, 'password': password}));
    if (response.statusCode == 200) {
      return loginModelFromJson(response.body);
    }
    if (response.statusCode == 400) {
      return null;
    } else {
      print('Get Api Authenticate False');
      throw Exception('Failed to load authenticate');
    }
  }

  Future<String?> verifyPhone(String phone) => _client.verifyPhone(phone);

  Future<String?> verifyCode(String code) => _client.verifyCode(code);

  Future<Map<String, dynamic>> authenticateFacebook() =>
      _client.authenticateFecebook();
}
