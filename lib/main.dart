import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_flutter/screens/login/role_screen.dart';
import 'package:login_flutter/services/injection/dependency_injection.dart';
import 'package:login_flutter/services/stores/auth_store.dart';
import 'screens/login/login_screen.dart';
import 'screens/home/home_screen.dart';

void main() {
  setupDependencies();
  // Ignorar errores SSL solo en desarrollo
  HttpOverrides.global = MyHttpOverrides();
  final authStore = sl.get<AuthStore>();
  debugShowCheckedModeBanner:
  false;
  debugDisableErrorBoundaries:
  false;
  runApp(
    MyApp(
      authStore: authStore,
    ),
  );
}

// Clase para sobrescribir el manejo de SSL
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Permitir certificados no válidos
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  final AuthStore authStore;

  const MyApp({super.key, required this.authStore});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iDempiere App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const LoginScreen(), // Pantalla de inicio de sesión
        '/home': (context) => const HomeScreen(), // Pantalla principal
        '/role-selection': (context) => const RolScreen(),
      },
    );
  }
}
