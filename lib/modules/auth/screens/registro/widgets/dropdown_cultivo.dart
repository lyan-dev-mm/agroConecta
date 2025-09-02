import 'package:flutter/material.dart';

class DropdownCultivo extends StatelessWidget {
  final String seleccionActual;
  final Function(String?) onChanged;

  const DropdownCultivo({
    super.key,
    required this.seleccionActual,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final opciones = ['Maíz', 'Café', 'Aguacate'];
    return DropdownButton<String>(
      value: seleccionActual,
      onChanged: onChanged,
      items: opciones.map((String valor) {
        return DropdownMenuItem(value: valor, child: Text(valor));
      }).toList(),
    );
  }
}
