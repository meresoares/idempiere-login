// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RoleStore on _RoleStore, Store {
  late final _$selectedClientAtom =
      Atom(name: '_RoleStore.selectedClient', context: context);

  @override
  String get selectedClient {
    _$selectedClientAtom.reportRead();
    return super.selectedClient;
  }

  @override
  set selectedClient(String value) {
    _$selectedClientAtom.reportWrite(value, super.selectedClient, () {
      super.selectedClient = value;
    });
  }

  late final _$selectedRoleAtom =
      Atom(name: '_RoleStore.selectedRole', context: context);

  @override
  String get selectedRole {
    _$selectedRoleAtom.reportRead();
    return super.selectedRole;
  }

  @override
  set selectedRole(String value) {
    _$selectedRoleAtom.reportWrite(value, super.selectedRole, () {
      super.selectedRole = value;
    });
  }

  late final _$selectedOrganizationAtom =
      Atom(name: '_RoleStore.selectedOrganization', context: context);

  @override
  String get selectedOrganization {
    _$selectedOrganizationAtom.reportRead();
    return super.selectedOrganization;
  }

  @override
  set selectedOrganization(String value) {
    _$selectedOrganizationAtom.reportWrite(value, super.selectedOrganization,
        () {
      super.selectedOrganization = value;
    });
  }

  late final _$rolesAtom = Atom(name: '_RoleStore.roles', context: context);

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

  late final _$organizationsAtom =
      Atom(name: '_RoleStore.organizations', context: context);

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

  late final _$fetchRolesAsyncAction =
      AsyncAction('_RoleStore.fetchRoles', context: context);

  @override
  Future<void> fetchRoles() {
    return _$fetchRolesAsyncAction.run(() => super.fetchRoles());
  }

  late final _$fetchOrganizationsAsyncAction =
      AsyncAction('_RoleStore.fetchOrganizations', context: context);

  @override
  Future<void> fetchOrganizations() {
    return _$fetchOrganizationsAsyncAction
        .run(() => super.fetchOrganizations());
  }

  late final _$_RoleStoreActionController =
      ActionController(name: '_RoleStore', context: context);

  @override
  void updateSelectedClient(String newClient) {
    final _$actionInfo = _$_RoleStoreActionController.startAction(
        name: '_RoleStore.updateSelectedClient');
    try {
      return super.updateSelectedClient(newClient);
    } finally {
      _$_RoleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSelectedRole(String newRole) {
    final _$actionInfo = _$_RoleStoreActionController.startAction(
        name: '_RoleStore.updateSelectedRole');
    try {
      return super.updateSelectedRole(newRole);
    } finally {
      _$_RoleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSelectedOrganization(String newOrganization) {
    final _$actionInfo = _$_RoleStoreActionController.startAction(
        name: '_RoleStore.updateSelectedOrganization');
    try {
      return super.updateSelectedOrganization(newOrganization);
    } finally {
      _$_RoleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedClient: ${selectedClient},
selectedRole: ${selectedRole},
selectedOrganization: ${selectedOrganization},
roles: ${roles},
organizations: ${organizations}
    ''';
  }
}
