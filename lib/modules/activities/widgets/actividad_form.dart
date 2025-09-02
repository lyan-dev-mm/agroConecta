import 'package:flutter/material.dart';
import 'package:agroconecta/models/actividad_model.dart';

class ActividadForm extends StatefulWidget {
  final Function(Actividad) onSave;

  const ActividadForm({Key? key, required this.onSave}) : super(key: key);

  @override
  State<ActividadForm> createState() => _ActividadFormState();
}

class _ActividadFormState extends State<ActividadForm> {
  final _formKey = GlobalKey<FormState>();
  String tipo = '';
  String descripcion = '';
  DateTime fecha = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nueva Actividad'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Tipo'),
              onSaved: (value) => tipo = value ?? '',
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Descripción'),
              onSaved: (value) => descripcion = value ?? '',
            ),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: fecha,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) setState(() => fecha = picked);
              },
              child: Text('Fecha: ${fecha.toLocal().toString().split(' ')[0]}'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _formKey.currentState?.save();
            final nuevaActividad = Actividad(
              id: DateTime.now().toString(),
              tipo: tipo,
              descripcion: descripcion,
              fecha: fecha,
            );
            widget.onSave(nuevaActividad);
            Navigator.of(context).pop();
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
