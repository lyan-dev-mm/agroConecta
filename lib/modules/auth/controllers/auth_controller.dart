import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // login exitoso
    } catch (e) {
      return 'Correo o contraseña incorrectos';
    }
  }

  User? get usuarioActual => _auth.currentUser;
}
