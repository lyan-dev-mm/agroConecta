import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import de provider
import 'package:agroconecta/modules/auth/providers/registro_usuario_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'formulario_agricultor.dart';
import 'formulario_consumidor.dart';

class SelectorTipoUsuario extends ConsumerWidget {
  const SelectorTipoUsuario({super.key});

  Future<void> seleccionarTipo(
    BuildContext context,
    WidgetRef ref,
    String tipo,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tipoUsuario', tipo);

    ref.read(registroUsuarioProvider.notifier).actualizarTipoUsuario(tipo);

    if (tipo == 'agricultor') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AgricultorRegister()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ConsumidorRegister()),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.agriculture,
                size: 100,
                color: Color(0xFF4BA43F),
              ),
              const SizedBox(height: 20),
              const Text(
                'Cuenta asociada a...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  color: Color(0xFF4BA43F),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Selecciona una opción para continuar',
                style: TextStyle(fontSize: 16, fontFamily: 'Inter'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => seleccionarTipo(context, ref, 'agricultor'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4BA43F),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Inter',
                  ),
                ),
                child: const Text('Agricultor'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => seleccionarTipo(context, ref, 'consumidor'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4BA43F),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Inter',
                  ),
                ),
                child: const Text('Consumidor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
