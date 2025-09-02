import 'package:agroconecta/modules/auth/screens/create_account.dart';
import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final _authController = AuthController();
  String mensajeError = '';

  void _intentarLogin() async {
    final resultado = await _authController.login(
      emailCtrl.text,
      passCtrl.text,
    );

    if (resultado == null) {
      // Éxito
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Inicio de sesión exitoso')));
      // Aquí podrías navegar a tu pantalla principal
    } else {
      setState(() => mensajeError = resultado);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Inicio de sesión',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                color: Color(0xFF4BA43F),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ingrese su correo electrónico:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            const SizedBox(height: 10),

            EmailField(controller: emailCtrl),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ingrese su contraseña:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 10),

            PasswordField(controller: passCtrl),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _intentarLogin,
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
              child: const Text('Entrar'),
            ),

            const SizedBox(height: 50),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateAccount()),
                );
              },
              child: const Text(
                '¿Ha olvido su contraseña?',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  color: Color(0xFF4BA43F),
                ),
                textAlign: TextAlign.left,
              ),
            ),

            if (mensajeError.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  mensajeError,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
