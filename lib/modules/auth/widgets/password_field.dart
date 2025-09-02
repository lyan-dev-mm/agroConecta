import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordField({super.key, required this.controller});

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _mostrarPass = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !_mostrarPass, // Oculta o muestra el texto
      cursorColor: Color(0xFF4BA43F),
      decoration: InputDecoration(
        hintText: 'Contraseña',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(
            _mostrarPass ? Icons.visibility : Icons.visibility_off,
            color: Color(0xFF4BA43F),
          ),
          onPressed: () {
            setState(() {
              _mostrarPass = !_mostrarPass;
            });
          },
        ),
      ),
    );
  }
}
