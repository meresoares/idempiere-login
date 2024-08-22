import 'package:flutter/material.dart';

class LoginButtons extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const LoginButtons({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: isLoading ? null : onPressed,
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
        const SizedBox(height: 24),
        /*ElevatedButton(
          onPressed: isLoading ? null : onPressed,
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
        ),*/
        
      ],
    );
  }
}
