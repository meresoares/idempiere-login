import 'package:flutter/material.dart';
import 'package:login_flutter/screens/Login/login_rol_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedLanguage = 'es_PY';
  bool _selectRole = false;
  bool _rememberMe = false;

  void _login() {
    if (_selectRole) {
      // Navegar a la pantalla de selección de rol y organización
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginRol()),
      );
    } else {
      // Navegar directamente a la pantalla home
      Navigator.pushReplacementNamed(context, '/home');
    }
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
                    Image.asset(
                      'assets/images/monalisa_logo.webp',
                      height: 100,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Entrar al sistema",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.visibility),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedLanguage,
                      decoration: const InputDecoration(
                        labelText: 'Lenguaje',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        const DropdownMenuItem(
                          child: Text('Español (Colombia)'),
                          value: 'es_CO',
                        ),
                        const DropdownMenuItem(
                          child: Text('Español (Paraguay)'),
                          value: 'es_PY',
                        ),
                        const DropdownMenuItem(
                          child: Text('English'),
                          value: 'en_US',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: _selectRole,
                          onChanged: (value) {
                            setState(() {
                              _selectRole = value!;
                            });
                          },
                        ),
                        const Text('Seleccionar rol'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                        const Text('Recordar mis datos'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _login,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check),
                          SizedBox(width: 8),
                          Text('Inicia sesión')
                        ],
                      ),
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
