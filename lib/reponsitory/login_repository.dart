import 'package:severingthing/client/login_client.dart';

class LoginRepository {
  final _client = LoginClient();

  Future<String?> authenticate(String userName, String password) =>
      _client.authenticate(userName, password);

  Future<String?> verifyPhone(String phone) => _client.verifyPhone(phone);

  Future<Map<String, dynamic>> authenticateFacebook() =>
      _client.authenticateFecebook();
}
