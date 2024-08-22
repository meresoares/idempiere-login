import 'package:flutter/material.dart';
import 'package:login_flutter/screens/home_screen.dart';
import 'package:login_flutter/screens/role_screen.dart';
import 'package:login_flutter/services/api_service.dart';
import 'package:login_flutter/services/client_store.dart'; // Cambia esto si es necesario
import 'package:login_flutter/services/role_store.dart';
import 'package:login_flutter/widgets/checkbox.widget.dart';
import 'package:login_flutter/widgets/login_button.widget.dart';
import 'package:login_flutter/widgets/logo.widget.dart';
import 'package:login_flutter/widgets/textfield.widget.dart';
import 'package:login_flutter/widgets/title.widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Obtén las instancias desde una clase de gestión de estado o inyección de dependencias
  final AuthStore authStore = AuthStore();  // Debes pasar esto desde un gestor
  final RoleStore roleStore = RoleStore(AuthStore());
  final ApiService apiService = ApiService();

  bool _selectRole = false;
  bool _obscureText = true;
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await authStore.login(
        _usernameController.text,
        _passwordController.text,
      );

    // Verifica si el token y los clientes fueron cargados
    print('Token después del login en LoginScreen: ${authStore.token}');
    print('Clientes cargados en LoginScreen: ${authStore.clients}');

      if (_selectRole) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoleScreen(
              authStore: authStore,
              roleStore: roleStore,
              apiService: apiService,
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
                    const TitleText(text: 'Entrar al sistema'),
                    const SizedBox(height: 24),
                    CustomTextField(
                      controller: _usernameController,
                      labelText: 'Usuario',
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Contraseña',
                      obscureText: _obscureText,
                      onToggleVisibility: _togglePasswordView,
                      showVisibilityIcon: true,
                    ),
                    const SizedBox(height: 16),
                    CustomCheckbox(
                      value: _selectRole,
                      onChanged: (value) {
                        setState(() {
                          _selectRole = value!;
                        });
                      },
                      label: 'Seleccionar rol',
                    ),
                    /*CustomCheckbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                      label: 'Recordar mis datos',
                    ), */
                    const SizedBox(height: 24),
                    LoginButtons(
                      onPressed: _login,
                      isLoading: _isLoading,
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
}
