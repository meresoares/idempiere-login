import 'package:login_flutter/services/auth_service.dart';
import 'package:mobx/mobx.dart';
import 'package:login_flutter/models/client_model.dart';
part 'client_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final AuthService _authService = AuthService();


  @observable
  String? token;

  @observable
  ObservableList<Client> clients = ObservableList<Client>();

  @action
  Future<void> login(String username, String password) async {
    print('Intentando iniciar sesión con $username');
    final Map<String, dynamic> response =
        await _authService.login(username, password);

    // Asegúrate de que el token es un String
    token = response['token'] as String?;
    print('Token guardado desde ClientStore: $token');

    // Verifica que clientsData es una lista dinámica
    final clientsData = response['clients'] as List<dynamic>;
    print('Datos de clientes recibidos en ClientStore: $clientsData');

    // Limpia la lista existente y agrega los nuevos datos
    clients.clear();
    clients.addAll(clientsData.map((clientData) {
      return Client.fromJson(clientData as Map<String, dynamic>);
    }).toList());

    print('Clientes guardados en ClientStore: $clients');
  }

  @computed
  bool get isAuthenticated => token != null;
}
