import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agroconecta/models/usuario_agri_registro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final registroUsuarioProvider =
    StateNotifierProvider<RegistroUsuarioNotifier, UsuarioAgriRegistro>(
      (ref) => RegistroUsuarioNotifier(),
    );

class RegistroUsuarioNotifier extends StateNotifier<UsuarioAgriRegistro> {
  RegistroUsuarioNotifier() : super(UsuarioAgriRegistro());

  void actualizarTipoUsuario(String tipoUsuario) {
    state = state.copyWith(tipoUsuario: tipoUsuario);
  }

  void actualizarNombre(String nombre) {
    state = state.copyWith(nombre: nombre);
  }

  void actualizarApellidos(String apellidos) {
    state = state.copyWith(apellidos: apellidos);
  }

  void actualizarGenero(String genero) {
    state = state.copyWith(genero: genero);
  }

  void actualizarCultivo(String cultivo) {
    state = state.copyWith(cultivo: cultivo);
  }

  void actualizarTecnica(String tecnica) {
    state = state.copyWith(tecnicaCultivo: tecnica);
  }

  void actualizarTamParcela(String tamParcela) {
    state = state.copyWith(tamParcela: tamParcela);
  }

  void actualizarUbicacion(double lat, double lon, double alt) {
    state = state.copyWith(latitud: lat, longitud: lon, altitud: alt);
  }

  void actualizarDireccion(String estado, String municipio, String comunidad) {
    state = state.copyWith(
      estado: estado,
      municipio: municipio,
      comunidad: comunidad,
    );
  }

  void asignarFoto(File foto) {
    state = state.copyWith(foto: foto);
  }

  Future<void> guardarUsuarioEnFirestore() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception('Usuario no autenticado');

    final usuarioMap = state.toMap(); // Este método debe estar en tu modelo

    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .set(usuarioMap);
  }
}
