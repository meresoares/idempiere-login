import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:login_flutter/models/client_model.dart';
import 'package:login_flutter/models/language_model.dart';
import 'package:login_flutter/models/organization_model.dart';
import 'package:login_flutter/models/role_model.dart';
import 'package:login_flutter/models/warehouse_model.dart';
import 'package:login_flutter/services/api_service.dart';
import 'package:login_flutter/services/client_store.dart';
import 'package:login_flutter/services/role_store.dart';
import 'package:login_flutter/widgets/dropdown.widget.dart';
import 'package:login_flutter/widgets/logo.widget.dart';
import 'package:login_flutter/widgets/title.widget.dart';

class RoleScreen extends StatefulWidget {
  final AuthStore authStore;
  final RoleStore roleStore;
  final ApiService apiService;

  RoleScreen(
      {required this.authStore,
      required this.roleStore,
      required this.apiService});

  @override
  _RoleScreenState createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  Client? _selectedClient;
  Role? _selectedRole;
  Organization? _selectedOrganization;
  Warehouse? _selectedWarehouse;
  Language? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  Future<void> _initializeScreen() async {
    // Depuración adicional
    print('Token en RoleScreen: ${widget.authStore.token}');
    print('Clientes en RoleScreen: ${widget.authStore.clients}');

    // Asignar el token y el cliente seleccionado
    if (widget.authStore.token != null) {
      widget.roleStore.updateToken(widget.authStore.token!);
    }

    // Asegura que los clientes existan antes de seleccionarlos
    if (widget.authStore.clients.isNotEmpty) {
      // Asigna el primer cliente como el seleccionado
      _selectedClient = widget.authStore.clients.first;
      widget.roleStore.updateSelectedClient(_selectedClient!.id.toString());

      // Verificación de la asignación de selectedClient
      print(
          'Selected Client después de la actualización en RoleScreen: ${widget.roleStore.selectedClient}');
    } else {
      print('No hay clientes cargados en RolScreen.');
    }

    // Cargar roles y seleccionar el primero
    await widget.roleStore.fetchRoles();
    if (widget.roleStore.roles.isNotEmpty) {
      setState(() {
        _selectedRole = widget.roleStore.roles.first;
        widget.roleStore.updateSelectedRole(_selectedRole!.id.toString());
      });
    }

    // Cargar organizaciones después de seleccionar el rol
    if (_selectedClient != null && _selectedRole != null) {
      await widget.roleStore.fetchOrganizations();
      if (widget.roleStore.organizations.isNotEmpty) {
        setState(() {
          _selectedOrganization = widget.roleStore.organizations.first;
          widget.roleStore
              .updateSelectedOrganization(_selectedOrganization!.id.toString());
        });
      }
    }

    // Cargar almacenes
    if (_selectedClient != null &&
        _selectedRole != null &&
        _selectedOrganization != null) {
      await widget.roleStore.fetchWarehouses();
    }

    // Cargar lenguajes y seleccionar el primero
    await widget.roleStore.fetchLanguage();
    print('Lista de lenguajes cargados: ${widget.roleStore.languages}');
    
    if (widget.roleStore.languages.isNotEmpty) {
      setState(() {
        _selectedLanguage = widget.roleStore.languages.first;
        widget.roleStore
            .updateSelectedLanguage(_selectedLanguage);
      });
    }

    print('Lista de almacenes en Dropdown: ${widget.roleStore.warehouses}');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    const Logo(imagePath: 'assets/images/monalisa_logo.webp'),
                    const SizedBox(height: 24),
                    const TitleText(text: 'Seleccionar el rol'),
                    const SizedBox(height: 24),
                    Observer(
                      builder: (_) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownRow<Client>(
                              title: 'Grupo empresarial: ',
                              value: _selectedClient,
                              items: widget.authStore.clients.toList(),
                              onChanged: (Client? newValue) async {
                                setState(() {
                                  _selectedClient = newValue;
                                  widget.roleStore.updateSelectedClient(
                                      _selectedClient!.id.toString());
                                });
                              },
                              itemBuilder: (Client client) => Text(client.name),
                              valueBuilder: (Client client) => client,
                            ),
                            DropdownRow<Role>(
                              title: 'Rol: ',
                              value: _selectedRole,
                              items: widget.roleStore.roles,
                              onChanged: (Role? newValue) async {
                                setState(() {
                                  _selectedRole = newValue;
                                  if (_selectedRole != null) {
                                    widget.roleStore.updateSelectedRole(
                                        _selectedRole!.id.toString());
                                  }
                                });
                              },
                              itemBuilder: (Role role) => Text(role.name),
                              valueBuilder: (Role role) => role,
                            ),
                            const SizedBox(height: 8),
                            const Text('DEFAULT'),
                            const SizedBox(height: 16),
                            DropdownRow<Organization>(
                              title: 'Organización: ',
                              value: _selectedOrganization,
                              items: widget.roleStore.organizations.toList(),
                              onChanged: (Organization? newValue) async {
                                setState(() {
                                  _selectedOrganization = newValue;
                                  if (_selectedOrganization != null) {
                                    widget.roleStore.updateSelectedOrganization(
                                        _selectedOrganization!.id.toString());
                                  }
                                });

                                // Cargar almacenes después de seleccionar la organización
                                if (_selectedOrganization != null) {
                                  await widget.roleStore.fetchWarehouses();

                                  // Forzar actualización de la UI
                                  setState(() {
                                    if (widget
                                        .roleStore.warehouses.isNotEmpty) {
                                      _selectedWarehouse =
                                          widget.roleStore.warehouses.first;
                                    } else {
                                      _selectedWarehouse =
                                          null; // O manejar el caso cuando no haya almacenes
                                    }
                                  });
                                }
                              },
                              itemBuilder: (Organization organization) =>
                                  Text(organization.name),
                              valueBuilder: (Organization organization) =>
                                  organization,
                            ),
                            const SizedBox(height: 16),
                            DropdownRow<Warehouse>(
                              title: 'Almacén: ',
                              value: _selectedWarehouse,
                              items: widget.roleStore.warehouses.toList(),
                              onChanged: (Warehouse? newValue) {
                                setState(() {
                                  _selectedWarehouse = newValue;
                                  if (_selectedWarehouse != null) {
                                    widget.roleStore.updateSelectedWarehouse(
                                        _selectedWarehouse!.id.toString());
                                  }
                                });
                              },
                              itemBuilder: (Warehouse warehouse) =>
                                  Text(warehouse.name),
                              valueBuilder: (Warehouse warehouse) => warehouse,
                            ),
                            const SizedBox(height: 16),
                            DropdownRow<Language>(
                              // Añadimos el dropdown para el lenguaje
                              title: 'Idioma: ',
                              value: _selectedLanguage,
                              items: widget.roleStore.languages,
                              onChanged: (Language? newValue) {
                                setState(() {
                                  _selectedLanguage = newValue;
                                  if (_selectedLanguage != null) {
                                    widget.roleStore.updateSelectedLanguage(_selectedLanguage);
                                  }
                                });
                              },
                              itemBuilder: (Language language) =>
                                  Text(language.identifier),
                              valueBuilder: (Language language) => language,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    // Aquí puedes agregar el botón de inicio de sesión
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
