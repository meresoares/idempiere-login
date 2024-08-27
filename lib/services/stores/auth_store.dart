import 'package:login_flutter/models/client_model.dart';
import 'package:login_flutter/models/language_model.dart';
import 'package:login_flutter/models/organization_model.dart';
import 'package:login_flutter/models/role_model.dart';
import 'package:login_flutter/models/warehouse_model.dart';
import 'package:login_flutter/services/api_service.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final ApiService _apiService;

  _AuthStore(this._apiService) {
    reaction((_) => isLoggedIn, (isLoggedIn) {
      if (isLoggedIn) {
        reaction((_) => selectedClient, (selectedClient) {
          if (selectedClient != null && clients.isNotEmpty) {
            fetchRoles(selectedClient.id.toString());
          }
        }, fireImmediately: true);
      }
    });
  }

  // Auth
  @observable
  String? token;
  @observable
  String? usernameS;
  @observable
  String? passwordS;

  // Client
  @observable
  ObservableList<Client> clients = ObservableList<Client>();
  @observable
  Client? selectedClient;

  // Role
  @observable
  ObservableList<Role> roles = ObservableList<Role>();
  @observable
  Role? selectedRole;

  // Organization
  @observable
  ObservableList<Organization> organizations = ObservableList<Organization>();
  @observable
  Organization? selectedOrganization;

  // Warehouse
  @observable
  ObservableList<Warehouse> warehouses = ObservableList<Warehouse>();
  @observable
  Warehouse? selectedWarehouse;

  // Language
  @observable
  ObservableList<Language> languages = ObservableList<Language>();
  @observable
  Language? selectedLanguage;

  @computed
  bool get isLoggedIn => token != null;

  @computed
  String? get _token => token;

  @action
  void updateToken(String _token) {
    token = _token;
  }

  @action
  void setToken(String _token) {
    token = _token;
  }

  @action
  Future<void> login(
    String username,
    String password,
    String? clientId,
    String? roleId,
    String? organizationId,
    String? warehouseId,
    String? languageId,
  ) async {
    try {
      if (clientId != null &&
          roleId != null &&
          organizationId != null &&
          warehouseId != null &&
          languageId != null) {
        final response = await _apiService.loginOneStep(
          userName: username,
          password: password,
          clientId: selectedClient?.id ?? 0,
          roleId: selectedRole?.id ?? 0,
          organizationId: selectedOrganization?.id ?? 0,
          warehouseId: selectedWarehouse?.id ?? 0,
          language: selectedLanguage?.identifier ?? '',
        );
        updateToken(response['token'] ?? '');
        usernameS = username;
        passwordS = password;
      } else if (token != null &&
          clientId != null &&
          roleId != null &&
          organizationId != null &&
          warehouseId != null &&
          languageId != null) {
        final response = await _apiService.finalLogin(
          authToken: token!,
          clientId: selectedClient?.id ?? 0,
          roleId: selectedRole?.id ?? 0,
          organizationId: selectedOrganization?.id ?? 0,
          warehouseId: selectedWarehouse?.id ?? 0,
          language: selectedLanguage?.id.toString() ?? '',
        );
      } else {
        final response = await _apiService.login(
          username: username,
          password: password,
        );
        updateToken(response['token']);
        usernameS = username;
        passwordS = password;

        // Obtener y almacenar la lista de clientes
        final fetchedClients = (response['clients'] as List)
            .map((clientData) => Client.fromJson(clientData))
            .toList();

        clients.clear();
        clients.addAll(fetchedClients);

        // Si la lista de clientes no está vacía, se selecciona el primer
        // cliente automáticamente llamando al método updateSelectedClient
        // con el ID del primer cliente.
        if (clients.isNotEmpty) {
          updateSelectedClient(clients.first);
        }
      }
    } catch (e) {
      print('Error al iniciar sesión: $e');
      rethrow; // re-lanzar la excepción para que se pueda manejar en el llamador
    }
  }
  
  /*@action
  void logout() {
    updateToken(null);
  } */

  @action
  void updateSelectedClient(Client client) {
    selectedClient = client;
  }

  @action
  Future<void> fetchRoles(String clientId) async {
    // Llamar a la API para obtener los roles
    try {
      final rolesData =
          await _apiService.fetchRoles(token!, selectedClient!.id.toString());
      roles.clear();
      roles.addAll(rolesData);
      if (roles.isNotEmpty) {
        updateSelectedRole(roles.first);
      }
      print('Roles: $roles');
    } catch (e) {
      print('Error en fetchRoles: $e');
    }
  }

  @action
  void updateSelectedRole(Role role) {
    selectedRole = role;
  }

  @action
  Future<void> fetchLanguages(String clientId) async {
    print('Selected organizacion fetchLanguage: $selectedLanguage');
    print('Token desde fetchLanguage: $token');
    try {
      final languagesData = await _apiService.fetchLanguages(
          token!, selectedClient!.id.toString());
      languages.clear();
      languages.addAll(languagesData);
      updateSelectedLanguage(languages.first);
      print('Lenguajes: $languages');
    } catch (e) {
      print('Error fetching lenguaje: $e');
    }
  }

  @action
  void updateSelectedLanguage(Language language) {
    selectedLanguage = language;
  }

  @action
  Future<void> fetchOrganizations(String roleId) async {
    print('Selected organizacion fetchOrg: $selectedOrganization');
    print('Token desde fetchOrg: $token');
    try {
      final organizationsData = await _apiService.fetchOrganizations(
          token!, selectedClient!.id.toString(), selectedRole!.id.toString());
      organizations.clear();
      organizations.addAll(organizationsData);
      updateSelectedOrganization(organizations.first);
      print('Organizaciones: $organizations');
    } catch (e) {
      print('Error fetching organizaciones: $e');
    }
  }

  @action
  void updateSelectedOrganization(Organization organization) {
    selectedOrganization = organization;
  }

  @action
  Future<void> fetchWarehouses(String organizationId) async {
    print('Selected organizacion fetchOrg: $selectedWarehouse');
    print('Token desde fetchWh: $token');
    try {
      final warehousesData = await _apiService.fetchWarehouses(
          token!,
          selectedClient!.id.toString(),
          selectedRole!.id.toString(),
          selectedOrganization!.id.toString());
      warehouses.clear();
      warehouses.addAll(warehousesData);
      updateSelectedWarehouse(warehouses.first);
      print('Almacenes: $warehouses');
    } catch (e) {
      print('Error fetching almacen: $e');
    }
  }

  @action
  void updateSelectedWarehouse(Warehouse warehouse) {
    selectedWarehouse = warehouse;
  }
}
