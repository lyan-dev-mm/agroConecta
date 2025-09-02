import 'dart:io';
import 'package:agroconecta/modules/auth/providers/registro_usuario_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class FotoPerfilController {
  final WidgetRef ref;
  FotoPerfilController(this.ref);

  Future<void> subirFoto() async {
    final picker = ImagePicker();
    final archivo = await picker.pickImage(source: ImageSource.camera);

    if (archivo != null) {
      final foto = File(archivo.path);
      ref.read(registroUsuarioProvider.notifier).asignarFoto(foto);
      print('Foto asignada correctamente');
    } else {
      print(
        'No se seleccionó ninguna foto. Se usará una imagen predeterminada.',
      );
    }
  }

  void guardarDatosPersonales(String nombre, String apellidos, String genero) {
    final notifier = ref.read(registroUsuarioProvider.notifier);
    notifier.actualizarNombre(nombre);
    notifier.actualizarApellidos(apellidos);
    notifier.actualizarGenero(genero);
  }

  bool datosCompletos() {
    final usuario = ref.read(registroUsuarioProvider);
    return usuario.nombre.trim().isNotEmpty &&
        usuario.apellidos.trim().isNotEmpty &&
        usuario.genero.trim().isNotEmpty &&
        usuario.latitud != 0 &&
        usuario.foto != null; // Si decides que la foto es obligatoria
  }
}
