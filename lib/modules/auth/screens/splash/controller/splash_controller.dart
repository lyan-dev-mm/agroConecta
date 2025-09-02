import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController {
  final BuildContext context;

  SplashController(this.context);

  Future<bool> verificarUsuarioRegistrado() async {
    await Future.delayed(const Duration(seconds: 2)); // simula splash
    final prefs = await SharedPreferences.getInstance();
    final registrado = prefs.getBool('usuarioRegistrado') ?? false;
    return registrado;
  }

  Future<bool> permisoYaConcedido() async {
    final permiso = await Permission.location.status;
    return permiso.isGranted;
  }

  Future<void> solicitarPermisoUbicacion() async {
    final permiso = await Permission.location.request();
    return;
  }
}
