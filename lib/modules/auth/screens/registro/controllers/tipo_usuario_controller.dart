import 'package:flutter/material.dart';
import 'package:agroconecta/modules/auth/providers/registro_usuario_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TipoUsuarioController {
  final WidgetRef ref;
  final BuildContext context;

  TipoUsuarioController(this.ref, this.context);

  Future<void> seleccionarTipo(String tipo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tipoUsuario', tipo);
    ref.read(registroUsuarioProvider.notifier).actualizarTipoUsuario(tipo);

    if (tipo == 'agricultor') {
      Navigator.pushNamed(context, '/agricultorRegister');
    } else {
      Navigator.pushNamed(context, '/consumidorRegister');
    }
  }
}
