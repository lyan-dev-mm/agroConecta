class ConsumidorController {
  bool validarCampos(String nombre, String region) {
    return nombre.isNotEmpty && region.isNotEmpty;
  }

  Future<void> guardarDatos(String nombre, String region) async {
    print('Datos consumidor guardados: $nombre - $region');
  }
}
