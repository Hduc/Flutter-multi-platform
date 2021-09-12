import 'package:get_it/get_it.dart';
import 'package:severingthing/managers/app_manager.dart';

GetIt service_locator = GetIt.instance;
void setupLocator() {
  service_locator.registerLazySingleton(() => AppManager());
}
