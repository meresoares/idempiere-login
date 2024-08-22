import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_flutter/screens/role_screen.dart';
import 'package:login_flutter/services/api_service.dart';
import 'package:login_flutter/services/client_store.dart';
import 'package:login_flutter/services/role_store.dart';
import 'screens/Login/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  // Ignorar errores SSL solo en desarrollo
  HttpOverrides.global = MyHttpOverrides();
  final authStore = AuthStore();
    runApp(MyApp(authStore: authStore,));
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

  MyApp({required this.authStore});

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
        '/': (context) => const Login(), // Pantalla de inicio de sesión
        '/home': (context) => HomeScreen(), // Pantalla principal
        '/role-selection': (context) => RoleScreen(authStore: AuthStore(), apiService: ApiService(), roleStore: RoleStore(authStore),),
      },
    );
  }
}
