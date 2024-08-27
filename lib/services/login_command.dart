// services/login_command.dart
import 'package:login_flutter/services/stores/auth_store.dart';

class LoginCommand {
  final AuthStore _authStore;
  //final ClientStore _clientStore;

  LoginCommand(this._authStore);

  Future execute({
    required String username,
    required String password,
    String? clientId,
    String? roleId,
    String? organizationId,
    String? warehouseId,
    String? languageId,
  }) async {
    await _authStore.login(
      username,
      password,
      clientId,
      roleId,
      organizationId,
      warehouseId,
      languageId,
    );
    //await _clientStore.login(userName: username, password: password);
  }
}
