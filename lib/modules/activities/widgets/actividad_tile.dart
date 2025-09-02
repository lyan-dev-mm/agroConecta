import 'package:flutter/material.dart';
import 'package:agroconecta/models/actividad_model.dart';

class ActividadTile extends StatelessWidget {
  final Actividad actividad;
  final VoidCallback onEdit;
  final Function(bool) onStatusChange;

  const ActividadTile({
    Key? key,
    required this.actividad,
    required this.onEdit,
    required this.onStatusChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Icon(
          actividad.completada
              ? Icons.check_circle
              : Icons.radio_button_unchecked,
          color: actividad.completada ? Colors.green : Colors.grey,
        ),
        title: Text(actividad.tipo),
        subtitle: Text(actividad.descripcion),
        trailing: IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
        onTap: () => onStatusChange(!actividad.completada),
      ),
    );
  }
}
