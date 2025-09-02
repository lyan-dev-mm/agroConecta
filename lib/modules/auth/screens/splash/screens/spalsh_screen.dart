import 'package:flutter/material.dart';
import 'package:agroconecta/modules/auth/screens/registro/screens/ubicacion_screen.dart';
import 'package:agroconecta/modules/auth/screens/registro/screens/location_permission_screen.dart';
import 'package:agroconecta/modules/auth/screens/splash/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SplashController(context);
    _iniciar();
  }

  Future<void> _iniciar() async {
    await Future.delayed(const Duration(seconds: 2)); // Simula splash visual

    final registrado = await _controller.verificarUsuarioRegistrado();
    final permisoConcedido = await _controller.permisoYaConcedido();

    if (registrado) {
      if (permisoConcedido) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const UbicacionScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LocationPermissionScreen()),
        );
      }
    } else {
      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CreateAccount()),
      );*/
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E8646),
      body: Center(
        child: Image.asset('assets/icons/agroconecta-icon.png', width: 200),
      ),
    );
  }
}
