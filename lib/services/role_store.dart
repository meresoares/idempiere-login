import 'dart:math';

import 'package:logging/logging.dart';
import 'package:login_flutter/models/language_model.dart';
import 'package:login_flutter/models/organization_model.dart';
import 'package:login_flutter/models/role_model.dart';
import 'package:login_flutter/models/warehouse_model.dart';
import 'package:login_flutter/services/api_service.dart';
import 'package:login_flutter/services/client_store.dart';
import 'package:mobx/mobx.dart';

part 'role_store.g.dart';

class RoleStore = _RoleStore with _$RoleStore;

abstract class _RoleStore with Store {
  AuthStore _authStore;
  final ApiService _apiService = ApiService();

  _RoleStore(this._authStore) {
    reaction((_) => _authStore.token, (token) {
      print('Token actualizado en RoleStore: $token');
      if (selectedClient.isNotEmpty && token != null) {
        fetchRoles();
      }
    });
  }

  @observable
  String selectedClient = '';

  @observable
  String selectedRole = '';

  @observable
  String selectedOrganization = '';

  @observable
  String selectedWarehouse = '';

  @observable
  Language? selectedLanguage;

  @observable
  ObservableList<Role> roles = ObservableList<Role>();

  @observable
  ObservableList<Organization> organizations = ObservableList<Organization>();

  @observable
  ObservableList<Warehouse> warehouses = ObservableList<Warehouse>();

  @observable
  ObservableList<Language> languages = ObservableList<Language>();

  @action
  void setAuthStore(AuthStore store) {
    _authStore = store;
    print('AuthStore configurado en RoleStore');
  }

  @action
  void updateSelectedClient(String clientId) {
    selectedClient = clientId;
    print('Cliente seleccionado en RoleStore: $selectedClient');
    fetchRoles();
  }

  @action
  void updateSelectedRole(String roleId) {
    selectedRole = roleId;
    print('Role seleccionado en RoleStore: $selectedRole');
    fetchOrganizations(); // Actualiza las organizaciones cuando cambia el rol
  }

  @action
  void updateSelectedOrganization(String newOrganization) {
    selectedOrganization = newOrganization;
    fetchWarehouses();
  }

  @action
  void updateSelectedWarehouse(String newWarehouse) {
    selectedWarehouse = newWarehouse;
  }

  @action
  void updateSelectedLanguage(Language? newLanguage) {
    print('Actualizando idioma seleccionado: ${newLanguage?.identifier}');
    selectedLanguage = newLanguage;
  }

  @action
  void updateToken(String token) {
    _authStore.token = token;
    print('Token actualizado en RoleStore: ${_authStore.token}');
  }

  @action
  Future<void> fetchRoles() async {
    await Future.delayed(Duration(milliseconds: 100));
    print('Token en RoleStore al llamar a fetchRoles: ${_authStore.token}');
    print('Cliente seleccionado en RoleStore: $selectedClient');

    if (selectedClient.isNotEmpty && _authStore.token != null) {
      try {
        final rolesData =
            await _apiService.fetchRoles(_authStore.token!, selectedClient);
        print('Roles data fetched: $rolesData'); // Verifica los datos obtenidos
        roles.clear();
        roles.addAll(rolesData);

        if (roles.isNotEmpty) {
          selectedRole = roles.first.id.toString();
          print('Rol seleccionado por defecto en RoleStore: $selectedRole');

          // Ahora llama a fetchOrganizations después de seleccionar el rol por defecto
          await fetchOrganizations();
        }
      } catch (e) {
        print('Error al obtener roles: $e');
      }
    } else {
      print('Token o cliente no valido en RoleStore');
    }
  }

  @action
  Future<void> fetchOrganizations() async {
    if (selectedClient.isNotEmpty && selectedRole.isNotEmpty) {
      try {
        final organizationsData = await _apiService.fetchOrganizations(
            _authStore.token!, selectedClient, selectedRole);

        // Limpiar y actualizar la lista de organizaciones
        organizations.clear();
        organizations.addAll(organizationsData);

        // Asegúrate de que organizationsData es una lista
        if (organizations.isNotEmpty) {
          selectedOrganization = organizations.first.id.toString();
          print('Organización seleccionada por defecto: $selectedOrganization');
          // Llama a fetchWarehouses después de seleccionar la organización por defecto
          await fetchWarehouses();
        } else {
          print('Formato de respuesta inesperado: $organizationsData');
        }
      } catch (e) {
        print('Error al obtener organizaciones: $e');
      }
    }
  }

  @action
  Future<void> fetchWarehouses() async {
    try {
      final List<Warehouse> response = await _apiService.fetchWarehouses(
          _authStore.token!,
          selectedClient,
          selectedRole,
          selectedOrganization);

      // Imprimir la respuesta para verificar los datos
      print(
          'Respuesta de almacenes: ${response.map((w) => w.toString()).toList()}');

      warehouses = ObservableList<Warehouse>.of(response);

      if (warehouses.isNotEmpty) {
        selectedWarehouse = warehouses.first.id.toString();
      }

      warehouses.clear();
      warehouses.addAll(response); // Actualiza la lista observable

      print('Almacenes cargados correctamente: ${warehouses.length}');
    } catch (e) {
      print('Error al obtener almacenes: $e');
    }
  }

  @action
  Future<void> fetchLanguage() async {
    try {
      final List<Language> languageData =
          await _apiService.fetchLanguages(_authStore.token!, selectedClient);
      // Seleccionamos el primer lenguaje disponible

      if (languageData.isNotEmpty) {
        languages = ObservableList<Language>.of(languageData);
        selectedLanguage = languageData.first;
        //print('Lenguaje seleccionado por defecto: $selectedLanguage');
        // print('Lista de lenguajes cargados: $languages');
        Logger(
            'Lenguaje seleccionado por defecto identificador: ${selectedLanguage?.identifier}');
        Logger(
            'Lista de lenguajes cargados identificador: ${languages.map((lang) => lang.identifier).toList()}');
      } else {
        Logger('Lenguaje seleccionado por defecto: $selectedLanguage');
      }
    } catch (e) {
      Logger('Error al obtener lenguaje: $e');
    }
  }
}
