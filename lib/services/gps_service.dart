import 'package:geolocator/geolocator.dart';

class GpsService {
  Future<Position?> obtenerPosicionActual() async {
    bool servicioActivo = await Geolocator.isLocationServiceEnabled();
    if (!servicioActivo) {
      print('El servicio de ubicación está desactivado.');
      return null;
    }

    LocationPermission permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.deniedForever) return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<double> obtenerAltitud(Position posicion) async {
    // Simulación simple para este ejemplo
    return posicion.altitude;
  }
}
