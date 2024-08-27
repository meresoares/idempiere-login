import 'package:flutter/material.dart';
import 'package:login_flutter/screens/home/home_screen.dart';
import 'package:login_flutter/screens/login/role_screen.dart';
import 'package:login_flutter/services/login_command.dart';
import 'package:login_flutter/services/stores/auth_store.dart';
import 'package:login_flutter/widgets/checkbox.widget.dart';
import 'package:login_flutter/widgets/login_button.widget.dart';
import 'package:login_flutter/widgets/logo.widget.dart';
import 'package:login_flutter/widgets/textfield.widget.dart';
import 'package:login_flutter/widgets/title.widget.dart';
import 'package:get_it/get_it.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Inicializa las instancias necesarias
  final AuthStore _authStore = GetIt.I<AuthStore>();
  late LoginCommand _loginCommand;

  bool _selectRole = false;
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loginCommand = LoginCommand(_authStore);
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
                    const SizedBox(height: 24),
                    LoginButtons(
                      onLogin: _login,
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

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _loginCommand.execute(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      if (_selectRole) {
        _navigateToRoleScreen();
      } else {
        _navigateToHomeScreen();
      }
    } catch (e) {
      _showError(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToRoleScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RolScreen(),
      ),
    );
  }

  void _navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _showError(dynamic error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al iniciar sesión: $error')),
    );
  }
}
