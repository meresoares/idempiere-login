import 'package:flutter/material.dart'; 

class LoginRol extends StatelessWidget {
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
          padding: const EdgeInsets.all(24.0), // Relleno de 24 píxeles alrededor del contenido
          child: Card(
            elevation: 8, // Sombra del card, da un efecto de elevación
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // Bordes redondeados del card
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0), // Relleno interno del card
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del column al contenido mínimo
                children: [
                  const SizedBox(height: 24), // Espacio vertical de 24 píxeles
                  const Text(
                    '¡Bienvenido!', // Texto que se muestra en la pantalla
                    style: TextStyle(
                      fontSize: 24, // Tamaño de la fuente del texto
                      fontWeight: FontWeight.bold, // Peso de la fuente del texto
                    ),
                  ),
                  const SizedBox(height: 24), // Espacio vertical de 24 píxeles
                  Image.asset(
                    'assets/images/monalisa_logo.webp', // Ruta de la imagen a mostrar
                    height: 100, // Altura de la imagen
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
