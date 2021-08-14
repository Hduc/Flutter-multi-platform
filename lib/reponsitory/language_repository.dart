import 'package:severingthing/client/perferences.dart';

class LangueRepository {
  final _preferences = Preferences();
  Future<String?> getLanguage() => _preferences.getLanguage();

  Future<bool> setLanguage(String language) =>
      _preferences.setLanguage(language);
}
