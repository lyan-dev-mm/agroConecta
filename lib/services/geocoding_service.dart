// lib/services/geocoding_service.dart
import 'package:geocoding/geocoding.dart';

class GeocodingService {
  Future<Map<String, String>> reverseGeocode(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        print('Resultado completo: $place');
        print('Estado: ${place.administrativeArea}');
        print('Municipio: ${place.subAdministrativeArea}');
        print('Comunidad: ${place.locality}');
        return {
          //'estado': place.administrativeArea ?? '',
          //'municipio': place.subAdministrativeArea ?? '',
          //'comunidad': place.locality ?? '',
          'estado': place.administrativeArea ?? '',
          'municipio': place.subAdministrativeArea?.isNotEmpty == true
              ? place.subAdministrativeArea!
              : place.name ?? '',
          'comunidad': place.locality?.isNotEmpty == true
              ? place.locality!
              : place.thoroughfare ?? '',
        };
      }
    } catch (e) {
      print('Error en geocoding: $e');
    }
    return {};
  }
}
