import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agroconecta/modules/auth/providers/registro_usuario_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agroconecta/services/cloudinary_service.dart';
import 'package:agroconecta/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistroTecnicoController {
  final WidgetRef ref;
  final BuildContext context;

  RegistroTecnicoController(this.ref, this.context);

  void guardarFichaTecnica(String cultivo, String tecnica, String tamParcela) {
    final notifier = ref.read(registroUsuarioProvider.notifier);
    notifier.actualizarCultivo(cultivo);
    notifier.actualizarTecnica(tecnica);
    notifier.actualizarTamParcela(tamParcela);
  }

  Future<void> finalizarRegistro() async {
    final usuario = ref.read(registroUsuarioProvider);
    final usuarioID = FirebaseAuth.instance.currentUser?.uid;
    if (usuarioID == null) {
      //No hay usuario auntenticado
      return;
    }

    if (usuario.foto == null) {
      // Mostrar un mensaje de error, por ejemplo con un SnackBar
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Imagen predeterminada!')));
      return;
    }

    try {
      final urlFoto = await CloudinaryService().uploadImage(
        imageFile: usuario.foto!,
        folder: 'perfil',
        fileName: 'usuario_${usuarioID}_foto',
      );

      final datos = usuario.toMap()..['fotoPerfil'] = urlFoto;

      await FirestoreService().guardarDatosAgricultor(usuarioID, datos);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('usuarioRegistrado', true);

      // Navegar a la pantalla principal
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      // Mostrar error en pantalla
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ocurrió un error: $e')));
    }
  }
}
