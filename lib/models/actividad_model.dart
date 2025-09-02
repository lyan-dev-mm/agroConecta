class Actividad {
  final String id;
  final String tipo;
  final String descripcion;
  final DateTime fecha;
  bool completada;

  Actividad({
    required this.id,
    required this.tipo,
    required this.descripcion,
    required this.fecha,
    this.completada = false,
  });
}
