class UbicacionModel {
  final String estado;
  final String municipio;
  final String comunidad;
  final double? latitud;
  final double? longitud;

  UbicacionModel({
    required this.estado,
    required this.municipio,
    this.comunidad = '',
    this.latitud,
    this.longitud,
  });

  Map<String, dynamic> toMap() => {
    'estado': estado,
    'municipio': municipio,
    'comunidad': comunidad,
    'latitud': latitud,
    'longitud': longitud,
  };
}
