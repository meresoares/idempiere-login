import 'package:flutter/material.dart';

class LoginButtons extends StatelessWidget {
  final VoidCallback onLogin; // Acción al hacer clic en el botón de iniciar sesión
  final VoidCallback? onCancel; // Acción al hacer clic en el botón de cancelar
  final bool isLoading; // Indica si el botón debe mostrar el indicador de carga
  final bool showCancelButton; // Decide si mostrar el botón de cancelar

  const LoginButtons({
    super.key,
    required this.onLogin,
    this.onCancel,
    this.isLoading = false,
    this.showCancelButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: isLoading ? null : onLogin,
          child: isLoading
              ? const CircularProgressIndicator()
              : const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check),
                    SizedBox(width: 8),
                    Text('Iniciar sesión')
                  ],
                ),
        ),
        if (showCancelButton) ...[
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: isLoading ? null : onCancel,
            child: isLoading
                ? const CircularProgressIndicator()
                : const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cancel),
                      SizedBox(width: 8),
                      Text('Cancelar')
                    ],
                  ),
          ),
        ],
      ],
    );
  }
}
