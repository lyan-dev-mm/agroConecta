import 'package:flutter/material.dart';

class BotonesNavegacion extends StatelessWidget {
  final VoidCallback onAtras;
  final VoidCallback onSiguiente;

  const BotonesNavegacion({
    super.key,
    required this.onAtras,
    required this.onSiguiente,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
          ),
          onPressed: onAtras,
          child: const Text('Atrás', style: TextStyle(color: Colors.black)),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4BA43F),
          ),
          onPressed: onSiguiente,
          child: const Text(
            'Siguiente',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
