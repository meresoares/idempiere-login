import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:login_flutter/models/client_model.dart';
import 'package:login_flutter/models/language_model.dart';
import 'package:login_flutter/models/organization_model.dart';
import 'package:login_flutter/models/role_model.dart';
import 'package:login_flutter/models/warehouse_model.dart';
import 'package:login_flutter/services/stores/auth_store.dart';
import 'package:login_flutter/widgets/login_button.widget.dart';
import 'package:login_flutter/widgets/logo.widget.dart';
import 'package:login_flutter/widgets/title.widget.dart';

class RolScreen extends StatefulWidget {
  const RolScreen({super.key});

  @override
  State<RolScreen> createState() => _RolScreenState();
}

class _RolScreenState extends State<RolScreen> {
  final _controllerAuth = GetIt.I<AuthStore>();

  @override
  void initState() {
    _controllerAuth.login;
    _fetchDefaultValues();
    super.initState();
  }

  Future<void> _fetchDefaultValues() async {
    await _controllerAuth
        .fetchRoles(_controllerAuth.selectedClient!.id.toString());
    await _controllerAuth
        .fetchLanguages(_controllerAuth.selectedClient!.id.toString());
    await _controllerAuth
        .fetchOrganizations(_controllerAuth.selectedRole!.id.toString());

    // Inicializa selectedWarehouse con un valor vacío
    _controllerAuth.selectedWarehouse = null;

    await _controllerAuth
        .fetchWarehouses(_controllerAuth.selectedWarehouse!.id.toString());

    // Set default values
    _controllerAuth.selectedClient = _controllerAuth.clients.first;
    _controllerAuth.selectedRole = _controllerAuth.roles.first;
    await _controllerAuth
        .fetchLanguages(_controllerAuth.selectedClient!.id.toString());
    _controllerAuth.selectedLanguage = _controllerAuth.languages.first;
    _controllerAuth.selectedOrganization = _controllerAuth.organizations.first;
    await _controllerAuth
        .fetchOrganizations(_controllerAuth.selectedRole!.id.toString());
    _controllerAuth.selectedOrganization = _controllerAuth.organizations.first;
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
                            const SizedBox(height: 24),
                            const Text('Grupo empresarial'),
                            DropdownButton<Client>(
                              value: _controllerAuth.selectedClient!,
                              hint: const Text('Selecciona un cliente'),
                              onChanged: (Client? newValue) {
                                setState(() {
                                  _controllerAuth.selectedClient = newValue;
                                  // Actualiza el cliente seleccionado en el store
                                  if (_controllerAuth.selectedClient != null) {
                                    _controllerAuth.fetchRoles(_controllerAuth
                                        .selectedClient!.id
                                        .toString());
                                  }
                                });
                              },
                              items: _controllerAuth.clients
                                  .map<DropdownMenuItem<Client>>(
                                      (Client client) {
                                return DropdownMenuItem<Client>(
                                  value: client,
                                  child: Text(client.name),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 24),
                            const Text('Rol'),
                            DropdownButton<Role>(
                              value: _controllerAuth.selectedRole,
                              hint: const Text('Selecciona un rol'),
                              onChanged: (Role? newValue) {
                                setState(() {
                                  _controllerAuth.selectedRole = newValue;
                                  if (_controllerAuth.selectedRole != null) {
                                    _controllerAuth.fetchOrganizations(
                                        _controllerAuth.selectedRole!.id
                                            .toString());
                                  }
                                });
                              },
                              items: _controllerAuth.roles
                                  .map<DropdownMenuItem<Role>>((Role role) {
                                return DropdownMenuItem<Role>(
                                  value: role,
                                  child: Text(role.name),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'DEFAULT',
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            const Text('Organizacion'),
                            DropdownButton<Organization>(
                              value: _controllerAuth.selectedOrganization,
                              hint: const Text('Selecciona una organización'),
                              onChanged: (Organization? newValue) {
                                setState(() {
                                  _controllerAuth.selectedOrganization =
                                      newValue;
                                  if (_controllerAuth.selectedOrganization !=
                                      null) {
                                    _controllerAuth.fetchWarehouses(
                                        _controllerAuth.selectedOrganization!.id
                                            .toString());
                                  }
                                });
                              },
                              items: _controllerAuth.organizations
                                  .map<DropdownMenuItem<Organization>>(
                                      (Organization organization) {
                                return DropdownMenuItem<Organization>(
                                  value: organization,
                                  child: Text(organization.name),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 24),
                            const Text('Almacen'),
                            DropdownButton<Warehouse>(
                              value: _controllerAuth.selectedWarehouse,
                              hint: const Text(' '),
                              onChanged: (Warehouse? newvalue) {
                                setState(() {
                                  _controllerAuth.selectedWarehouse = newvalue;
                                  if (_controllerAuth.selectedWarehouse !=
                                      null) {
                                    _controllerAuth.selectedWarehouse!.id
                                        .toString();
                                  }
                                });
                              },
                              items: _controllerAuth.warehouses
                                  .map((warehouse) =>
                                      DropdownMenuItem<Warehouse>(
                                        value: warehouse,
                                        child: Text(warehouse
                                            .name), // or whatever property you want to display
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 24),
                            const Text('Lenguaje'),
                            DropdownButton<Language>(
                              value: _controllerAuth.selectedLanguage,
                              hint: const Text('Selecciona un lenguaje'),
                              onChanged: (Language? newValue) {
                                setState(() {
                                  _controllerAuth.selectedLanguage = newValue;
                                });
                              },
                              items: _controllerAuth.languages
                                  .map<DropdownMenuItem<Language>>(
                                      (Language language) {
                                return DropdownMenuItem<Language>(
                                  value: language,
                                  child: Text(language.identifier),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    LoginButtons(
                      onLogin: _handleLogin,
                      onCancel: _handleCancel,
                      isLoading: isLoading,
                      showCancelButton: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;

  void _handleLogin() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Llama a la API para realizar el login
      await _controllerAuth.login(
        _controllerAuth.usernameS ?? '',
        _controllerAuth.passwordS ?? '',
        _controllerAuth.selectedClient!.id.toString(),
        _controllerAuth.selectedRole!.id.toString(),
        _controllerAuth.selectedOrganization!.id.toString(),
        _controllerAuth.selectedWarehouse?.id.toString() ?? '',
        _controllerAuth.selectedLanguage!.id.toString(),
      );
      // Si el login es exitoso, navega a la siguiente pantalla
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      // Si hay un error, muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _handleCancel() {
    // Navega a la pantalla anterior
    Navigator.pop(context);
  }
}
