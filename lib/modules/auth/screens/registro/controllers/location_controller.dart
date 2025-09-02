import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agroconecta/services/gps_service.dart';

final locationControllerProvider =
    StateNotifierProvider<LocationController, LocationState>(
      (ref) => LocationController(),
    );

class LocationState {
  final double? latitud;
  final double? longitud;
  final double? altitud;
  final bool permissionGranted;

  const LocationState({
    this.latitud,
    this.longitud,
    this.altitud,
    this.permissionGranted = false,
  });

  LocationState copyWith({
    double? latitud,
    double? longitud,
    double? altitud,
    bool? permissionGranted,
  }) {
    return LocationState(
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      altitud: altitud ?? this.altitud,
      permissionGranted: permissionGranted ?? this.permissionGranted,
    );
  }
}

class LocationController extends StateNotifier<LocationState> {
  LocationController() : super(const LocationState());

  Future<void> requestLocationPermission(Function onGranted) async {
    final status = await Permission.location.request();
    final granted = status.isGranted;

    state = state.copyWith(permissionGranted: granted);

    if (granted) {
      final pos = await GpsService().obtenerPosicionActual();
      if (pos == null) return;

      final alt = await GpsService().obtenerAltitud(pos);

      state = state.copyWith(
        latitud: pos.latitude,
        longitud: pos.longitude,
        altitud: alt,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('permisoUbicacionConcedido', true);

      onGranted(); // Navegación o acción externa
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<bool> permisoYaConcedido() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('permisoUbicacionConcedido') ?? false;
  }
}
