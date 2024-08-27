// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool>? _$isLoggedInComputed;

  @override
  bool get isLoggedIn => (_$isLoggedInComputed ??=
          Computed<bool>(() => super.isLoggedIn, name: '_AuthStore.isLoggedIn'))
      .value;
  Computed<String?>? _$_tokenComputed;

  @override
  String? get _token => (_$_tokenComputed ??=
          Computed<String?>(() => super._token, name: '_AuthStore._token'))
      .value;

  late final _$tokenAtom = Atom(name: '_AuthStore.token', context: context);

  @override
  String? get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String? value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$usernameSAtom =
      Atom(name: '_AuthStore.usernameS', context: context);

  @override
  String? get usernameS {
    _$usernameSAtom.reportRead();
    return super.usernameS;
  }

  @override
  set usernameS(String? value) {
    _$usernameSAtom.reportWrite(value, super.usernameS, () {
      super.usernameS = value;
    });
  }

  late final _$passwordSAtom =
      Atom(name: '_AuthStore.passwordS', context: context);

  @override
  String? get passwordS {
    _$passwordSAtom.reportRead();
    return super.passwordS;
  }

  @override
  set passwordS(String? value) {
    _$passwordSAtom.reportWrite(value, super.passwordS, () {
      super.passwordS = value;
    });
  }

  late final _$clientsAtom = Atom(name: '_AuthStore.clients', context: context);

  @override
  ObservableList<Client> get clients {
    _$clientsAtom.reportRead();
    return super.clients;
  }

  @override
  set clients(ObservableList<Client> value) {
    _$clientsAtom.reportWrite(value, super.clients, () {
      super.clients = value;
    });
  }

  late final _$selectedClientAtom =
      Atom(name: '_AuthStore.selectedClient', context: context);

  @override
  Client? get selectedClient {
    _$selectedClientAtom.reportRead();
    return super.selectedClient;
  }

  @override
  set selectedClient(Client? value) {
    _$selectedClientAtom.reportWrite(value, super.selectedClient, () {
      super.selectedClient = value;
    });
  }

  late final _$rolesAtom = Atom(name: '_AuthStore.roles', context: context);

  @override
  ObservableList<Role> get roles {
    _$rolesAtom.reportRead();
    return super.roles;
  }

  @override
  set roles(ObservableList<Role> value) {
    _$rolesAtom.reportWrite(value, super.roles, () {
      super.roles = value;
    });
  }

  late final _$selectedRoleAtom =
      Atom(name: '_AuthStore.selectedRole', context: context);

  @override
  Role? get selectedRole {
    _$selectedRoleAtom.reportRead();
    return super.selectedRole;
  }

  @override
  set selectedRole(Role? value) {
    _$selectedRoleAtom.reportWrite(value, super.selectedRole, () {
      super.selectedRole = value;
    });
  }

  late final _$organizationsAtom =
      Atom(name: '_AuthStore.organizations', context: context);

  @override
  ObservableList<Organization> get organizations {
    _$organizationsAtom.reportRead();
    return super.organizations;
  }

  @override
  set organizations(ObservableList<Organization> value) {
    _$organizationsAtom.reportWrite(value, super.organizations, () {
      super.organizations = value;
    });
  }

  late final _$selectedOrganizationAtom =
      Atom(name: '_AuthStore.selectedOrganization', context: context);

  @override
  Organization? get selectedOrganization {
    _$selectedOrganizationAtom.reportRead();
    return super.selectedOrganization;
  }

  @override
  set selectedOrganization(Organization? value) {
    _$selectedOrganizationAtom.reportWrite(value, super.selectedOrganization,
        () {
      super.selectedOrganization = value;
    });
  }

  late final _$warehousesAtom =
      Atom(name: '_AuthStore.warehouses', context: context);

  @override
  ObservableList<Warehouse> get warehouses {
    _$warehousesAtom.reportRead();
    return super.warehouses;
  }

  @override
  set warehouses(ObservableList<Warehouse> value) {
    _$warehousesAtom.reportWrite(value, super.warehouses, () {
      super.warehouses = value;
    });
  }

  late final _$selectedWarehouseAtom =
      Atom(name: '_AuthStore.selectedWarehouse', context: context);

  @override
  Warehouse? get selectedWarehouse {
    _$selectedWarehouseAtom.reportRead();
    return super.selectedWarehouse;
  }

  @override
  set selectedWarehouse(Warehouse? value) {
    _$selectedWarehouseAtom.reportWrite(value, super.selectedWarehouse, () {
      super.selectedWarehouse = value;
    });
  }

  late final _$languagesAtom =
      Atom(name: '_AuthStore.languages', context: context);

  @override
  ObservableList<Language> get languages {
    _$languagesAtom.reportRead();
    return super.languages;
  }

  @override
  set languages(ObservableList<Language> value) {
    _$languagesAtom.reportWrite(value, super.languages, () {
      super.languages = value;
    });
  }

  late final _$selectedLanguageAtom =
      Atom(name: '_AuthStore.selectedLanguage', context: context);

  @override
  Language? get selectedLanguage {
    _$selectedLanguageAtom.reportRead();
    return super.selectedLanguage;
  }

  @override
  set selectedLanguage(Language? value) {
    _$selectedLanguageAtom.reportWrite(value, super.selectedLanguage, () {
      super.selectedLanguage = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthStore.login', context: context);

  @override
  Future<void> login(
      String username,
      String password,
      String? clientId,
      String? roleId,
      String? organizationId,
      String? warehouseId,
      String? languageId) {
    return _$loginAsyncAction.run(() => super.login(username, password,
        clientId, roleId, organizationId, warehouseId, languageId));
  }

  late final _$fetchRolesAsyncAction =
      AsyncAction('_AuthStore.fetchRoles', context: context);

  @override
  Future<void> fetchRoles(String clientId) {
    return _$fetchRolesAsyncAction.run(() => super.fetchRoles(clientId));
  }

  late final _$fetchOrganizationsAsyncAction =
      AsyncAction('_AuthStore.fetchOrganizations', context: context);

  @override
  Future<void> fetchOrganizations(String roleId) {
    return _$fetchOrganizationsAsyncAction
        .run(() => super.fetchOrganizations(roleId));
  }

  late final _$fetchWarehousesAsyncAction =
      AsyncAction('_AuthStore.fetchWarehouses', context: context);

  @override
  Future<void> fetchWarehouses(String organizationId) {
    return _$fetchWarehousesAsyncAction
        .run(() => super.fetchWarehouses(organizationId));
  }

  late final _$fetchLanguagesAsyncAction =
      AsyncAction('_AuthStore.fetchLanguages', context: context);

  @override
  Future<void> fetchLanguages(String clientId) {
    return _$fetchLanguagesAsyncAction
        .run(() => super.fetchLanguages(clientId));
  }

  late final _$_AuthStoreActionController =
      ActionController(name: '_AuthStore', context: context);

  @override
  void updateToken(String _token) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateToken');
    try {
      return super.updateToken(_token);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setToken(String _token) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.setToken');
    try {
      return super.setToken(_token);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSelectedClient(Client client) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateSelectedClient');
    try {
      return super.updateSelectedClient(client);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSelectedRole(Role role) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateSelectedRole');
    try {
      return super.updateSelectedRole(role);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSelectedOrganization(Organization organization) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateSelectedOrganization');
    try {
      return super.updateSelectedOrganization(organization);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSelectedWarehouse(Warehouse warehouse) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateSelectedWarehouse');
    try {
      return super.updateSelectedWarehouse(warehouse);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSelectedLanguage(Language language) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateSelectedLanguage');
    try {
      return super.updateSelectedLanguage(language);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
token: ${token},
usernameS: ${usernameS},
passwordS: ${passwordS},
clients: ${clients},
selectedClient: ${selectedClient},
roles: ${roles},
selectedRole: ${selectedRole},
organizations: ${organizations},
selectedOrganization: ${selectedOrganization},
warehouses: ${warehouses},
selectedWarehouse: ${selectedWarehouse},
languages: ${languages},
selectedLanguage: ${selectedLanguage},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
