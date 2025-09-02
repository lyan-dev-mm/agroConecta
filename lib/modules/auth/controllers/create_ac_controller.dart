import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> registrarUsuario(
  BuildContext context,
  String email,
  String password,
) async {
  // Validación: email y contraseña
  if (email.isEmpty || password.isEmpty) {
    mostrarMensaje(context, 'Completa todos los campos');
    return;
  }

  if (!email.contains('@') || !email.contains('.')) {
    mostrarMensaje(context, 'El correo no tiene un formato válido');
    return;
  }

  if (password.length < 6) {
    mostrarMensaje(context, 'La contraseña debe tener al menos 6 caracteres');
    return;
  }

  try {
    UserCredential cred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    mostrarMensaje(
      context,
      'Usuario registrado correctamente: ${cred.user?.email}',
    );
  } catch (e) {
    // Puedes personalizar los mensajes según el tipo de error
    mostrarMensaje(context, 'Error al registrar: $e');
  }
}

void mostrarMensaje(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
}
