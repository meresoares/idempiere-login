import 'package:flutter/material.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold proporciona una estructura básica para el diseño visual de la pantalla
      appBar: AppBar(
        title: const Text('Inicio'), // Título de la barra de aplicación (AppBar)
        backgroundColor: Colors.grey, // Color de fondo de la AppBar
      ),
      body: Center(
        // Centra el contenido en el medio de la pantalla
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
                  const Text(
                    '¡Bienvenido!',
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                  const SizedBox(height: 24), 
                  Image.asset(
                    'assets/images/monalisa_logo.webp', 
                    height: 100, 
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
