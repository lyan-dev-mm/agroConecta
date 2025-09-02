import 'dart:io';
import 'package:agroconecta/services/firestore_service.dart';
import 'package:agroconecta/services/cloudinary_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agroconecta/models/usuario_agri_registro.dart';
import 'package:agroconecta/modules/auth/validators/usuario_registro_validator.dart';

class AgricultorController {
  final firestore = FirestoreService();
  final cloudinary = CloudinaryService();

  UsuarioAgriRegistro _usuario = UsuarioAgriRegistro();

  void actualizarDatosBasicos({
    required String nombre,
    required String apellidos,
    required String genero,
  }) {
    _usuario = _usuario.copyWith(
      nombre: nombre,
      apellidos: apellidos,
      genero: genero,
    );
  }

  void actualizarUbicacion({
    required String estado,
    required String municipio,
    required String comunidad,
    required double latitud,
    required double longitud,
    required double altitud,
  }) {
    _usuario = _usuario.copyWith(
      estado: estado,
      municipio: municipio,
      comunidad: comunidad,
      latitud: latitud,
      longitud: longitud,
      altitud: altitud,
    );
  }

  void actualizarFichaTecnica({
    required String tamParcela,
    required String tecnicaCultivo,
    required String cultivo,
  }) {
    _usuario = _usuario.copyWith(
      tamParcela: tamParcela,
      tecnicaCultivo: tecnicaCultivo,
      cultivo: cultivo,
    );
  }

  void actualizarFoto(File foto) {
    _usuario = _usuario.copyWith(foto: foto);
  }

  bool validarCampos(String tamParcela, String tecnicaCultivo, String cultivo) {
    return tamParcela.isNotEmpty &&
        tecnicaCultivo.isNotEmpty &&
        cultivo.isNotEmpty;
  }

  Future<bool> registrarAgricultor() async {
    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario == null) return false;

    try {
      String? urlFoto;
      if (_usuario.foto != null) {
        urlFoto = await cloudinary.uploadImage(
          imageFile: _usuario.foto!,
          folder: 'perfil',
          fileName: 'usuario_${usuario.uid}_foto',
        );
      }

      final datos = UsuarioRegistroValidator.limpiarDatos(_usuario.toMap());
      if (urlFoto != null) datos['fotoPerfil'] = urlFoto;

      await firestore.guardarDatosAgricultor(usuario.uid, datos);
      return true;
    } catch (e) {
      print('Error al registrar agricultor: $e');
      return false;
    }
  }
}
