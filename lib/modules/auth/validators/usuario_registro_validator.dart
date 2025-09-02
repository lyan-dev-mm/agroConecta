import 'dart:io';
import 'package:agroconecta/models/usuario_agri_registro.dart';

class UsuarioRegistroValidator {
  static String? validarNombre(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre es obligatorio';
    }
    return null;
  }

  static String? validarApellidos(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Los apellidos son obligatorios';
    }
    return null;
  }

  static String? validarGenero(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Selecciona un género';
    }
    return null;
  }

  static String? validarCultivo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Selecciona un cultivo';
    }
    return null;
  }

  static String? validarTecnicaCultivo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La técnica de cultivo es obligatoria';
    }
    return null;
  }

  static String? validarTamParcela(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El tamaño de la parcela es obligatorio';
    }
    return null;
  }

  static String? validarEstado(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El estado es obligatorio';
    }
    return null;
  }

  static String? validarMunicipio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El municipio es obligatorio';
    }
    return null;
  }

  static String? validarComunidad(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La comunidad es obligatoria';
    }
    return null;
  }

  // Validaciones numéricas

  static String? validarLatitud(double value) {
    if (value == 0) return 'Ubicación no detectada';
    return null;
  }

  static String? validarLongitud(double value) {
    if (value == 0) return 'Ubicación no detectada';
    return null;
  }

  static String? validarAltitud(double value) {
    if (value == 0) return 'Altitud no detectada';
    return null;
  }

  static String? validarFoto(File? foto) {
    if (foto != null) return null;
    return null;
  }

  // Validación del modelo completo antes de guardar

  static bool modeloCompleto(UsuarioAgriRegistro usuario) {
    return usuario.nombre.trim().isNotEmpty &&
        usuario.apellidos.trim().isNotEmpty &&
        usuario.genero.trim().isNotEmpty &&
        usuario.cultivo.trim().isNotEmpty &&
        usuario.tecnicaCultivo.trim().isNotEmpty &&
        usuario.tamParcela.trim().isNotEmpty &&
        usuario.estado.trim().isNotEmpty &&
        usuario.municipio.trim().isNotEmpty &&
        usuario.comunidad.trim().isNotEmpty &&
        usuario.latitud != 0 &&
        usuario.longitud != 0 &&
        usuario.altitud != 0 &&
        usuario.foto != null;
  }

  // Limpieza del mapa antes de guardar

  static Map<String, dynamic> limpiarDatos(Map<String, dynamic> datos) {
    final limpio = <String, dynamic>{};
    datos.forEach((key, value) {
      if (value != null && value.toString().trim().isNotEmpty && value != 0) {
        limpio[key] = value;
      }
    });
    return limpio;
  }

  // Agrega más validaciones según lo que necesites
}
