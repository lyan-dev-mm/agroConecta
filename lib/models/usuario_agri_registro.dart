import 'dart:io';

class UsuarioAgriRegistro {
  final String tipoUsuario;
  final String nombre;
  final String apellidos;
  final String genero;
  final String cultivo;
  final String tecnicaCultivo;
  final String tamParcela;
  final String estado;
  final String municipio;
  final String comunidad;
  final double latitud;
  final double longitud;
  final double altitud;
  final File? foto;

  UsuarioAgriRegistro({
    this.tipoUsuario = 'agricultor',
    this.nombre = '',
    this.apellidos = '',
    this.genero = '',
    this.cultivo = '',
    this.tecnicaCultivo = '',
    this.tamParcela = '',
    this.estado = '',
    this.municipio = '',
    this.comunidad = '',
    this.latitud = 0,
    this.longitud = 0,
    this.altitud = 0,
    this.foto,
  });

  UsuarioAgriRegistro copyWith({
    String? tipoUsuario,
    String? nombre,
    String? apellidos,
    String? genero,
    String? cultivo,
    String? tecnicaCultivo,
    String? tamParcela,
    String? estado,
    String? municipio,
    String? comunidad,
    double? latitud,
    double? longitud,
    double? altitud,
    File? foto,
  }) {
    return UsuarioAgriRegistro(
      tipoUsuario: tipoUsuario ?? this.tipoUsuario,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      genero: genero ?? this.genero,
      cultivo: cultivo ?? this.cultivo,
      tecnicaCultivo: tecnicaCultivo ?? this.tecnicaCultivo,
      tamParcela: tamParcela ?? this.tamParcela,
      estado: estado ?? this.estado,
      municipio: municipio ?? this.municipio,
      comunidad: comunidad ?? this.comunidad,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      altitud: altitud ?? this.altitud,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tipoUsuario': tipoUsuario,
      'nombre': nombre,
      'apellidos': apellidos,
      'genero': genero,
      'cultivo': cultivo,
      'tecnicaCultivo': tecnicaCultivo,
      'tamParcela': tamParcela,
      'estado': estado,
      'municipio': municipio,
      'comunidad': comunidad,
      'latitud': latitud,
      'longitud': longitud,
      'altitud': altitud,
      'fotoPerfil': foto?.path,
    };
  }
}
