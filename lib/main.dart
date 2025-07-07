import 'package:flutter/material.dart';

void main() {
  runApp(const AgroConectaApp());
}

class AgroConectaApp extends StatelessWidget {
  const AgroConectaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroConect@',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF4BA43F)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToAgricultor(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AgricultorRegister()),
    );
  }

  void navigateToConsumidor(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConsumidorRegister()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo de la app
              const Icon(
                Icons.agriculture,
                size: 100,
                color: Color(0xFF4BA43F),
              ),
              const SizedBox(height: 20),

              //Titulo o texto de bienvenida
              const Text(
                'Cuenta asociada a..',
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

              // Botón Agricultor
              ElevatedButton(
                onPressed: () => navigateToAgricultor(context),
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

              // Botón Consumidor

              /*OutlinedButton(
                onPressed: () => navigateToConsumidor(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF4BA43F),
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: Color(0xFF4BA43F)),
                ),
                child: const Text('Consumidor'),
              ),*/
              ElevatedButton(
                onPressed: () => navigateToConsumidor(context),
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

class AgricultorRegister extends StatelessWidget {
  const AgricultorRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro Agricultor')),
      body: const Center(child: Text('Formulario para Agricultor')),
    );
  }
}

class ConsumidorRegister extends StatelessWidget {
  const ConsumidorRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro Consumidor')),
      body: const Center(child: Text('Formulario para Consumidor')),
    );
  }
}
