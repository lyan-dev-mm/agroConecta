import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await actualizarUltimoLogin();
      return credential.user;
    } catch (e) {
      print('❌ Error login: $e');
      return null;
    }
  }

  Future<User?> register(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await inicializarPerfil(credential.user);
      return credential.user;
    } catch (e) {
      print('❌ Error registro: $e');
      return null;
    }
  }

  Future<void> actualizarUltimoLogin() async {
    final user = _auth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('agricultores')
          .doc(user.uid)
          .update({'ultimoLogin': FieldValue.serverTimestamp()});
    }
  }

  Future<void> inicializarPerfil(User? user) async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('agricultores')
          .doc(user.uid)
          .set({
            'uid': user.uid,
            'email': user.email,
            'perfilCompleto': false,
            'ultimoLogin': FieldValue.serverTimestamp(),
          });
    }
  }
}
