import 'package:flutter/material.dart';
import '../controllers/create_ac_controller.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String mensajeError = '';

  void intentarRegistro() async {
    try {
      await registrarUsuario(context, emailCtrl.text.trim(), passCtrl.text);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('usuarioRegistrado', true);

      Navigator.pushReplacementNamed(context, '/ubicacion');
    } catch (e) {
      setState(() {
        mensajeError = 'Error al registrar: $e';
      });
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
              'Crear una cuenta',
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
              onPressed: intentarRegistro,
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
              child: const Text('Crear cuenta'),
            ),

            const SizedBox(height: 20),

            const Text(
              'o',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Inter',
                color: Colors.black87,
              ),
              textAlign: TextAlign.left,
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: Icon(FontAwesomeIcons.google, size: 30),
              label: Text('Continuar con Google'),
              onPressed: intentarRegistro,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Inter',
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: Icon(FontAwesomeIcons.facebook, size: 30),
              label: Text('Continuar con Facebook'),
              onPressed: intentarRegistro,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Inter',
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Al hacer clic en el botón, confirma que ha leído y acepta nuestros Términos de servicio y Política de privacidad.',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Inter',
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
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
