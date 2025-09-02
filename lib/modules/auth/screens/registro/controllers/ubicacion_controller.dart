import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:agroconecta/modules/auth/providers/registro_usuario_provider.dart';

class UbicacionController {
  final WidgetRef ref;
  final BuildContext context;

  UbicacionController(this.ref, this.context);

  Future<void> capturarUbicacionYContinuar() async {
    final posicion = await Geolocator.getCurrentPosition();
    ref
        .read(registroUsuarioProvider.notifier)
        .actualizarUbicacion(
          posicion.latitude,
          posicion.longitude,
          posicion.altitude,
        );

    Navigator.pushNamed(context, '/fotoPerfil');
  }

  final estadoCtrl = TextEditingController();
  final municipioCtrl = TextEditingController();
  final comunidadCtrl = TextEditingController();
  double? latitud;
  double? longitud;
  double? altitud;

  Map<String, dynamic> obtenerDireccion() {
    return {
      'estado': estadoCtrl.text.trim(),
      'municipio': municipioCtrl.text.trim(),
      'comunidad': comunidadCtrl.text.trim(),
      'latitud': latitud,
      'longitud': longitud,
      'altitud': latitud,
    };
  }

  bool validarUbicacion() {
    return estadoCtrl.text.trim().isNotEmpty &&
        municipioCtrl.text.trim().isNotEmpty &&
        comunidadCtrl.text.trim().isNotEmpty;
  }

  void limpiar() {
    estadoCtrl.clear();
    municipioCtrl.clear();
    comunidadCtrl.clear();
  }
}
