import 'package:get_it/get_it.dart';
import 'package:login_flutter/services/api_service.dart';
import 'package:login_flutter/services/stores/auth_store.dart';

final sl = GetIt.I;

void setupDependencies() {
  // Singletons
  sl.registerLazySingleton<ApiService>(() => ApiService());

  sl.registerSingleton<AuthStore>(AuthStore(sl.get<ApiService>()));

  // Servicios

  // Stores

}
