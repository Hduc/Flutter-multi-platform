class Validations {
  static bool isValidUser(String user) {
    return user != null && user.length > 6 && user.contains("@");
  }

  static bool isValidPass(String pass) {
    return pass != null && pass.length > 6;
  }
}