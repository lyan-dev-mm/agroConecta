import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../controllers/consumidor_controller.dart';

class ConsumidorRegister extends StatelessWidget {
  const ConsumidorRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final nombreCtrl = TextEditingController();
    final regionCtrl = TextEditingController();
    final controller = ConsumidorController();

    return Scaffold(
      appBar: AppBar(title: const Text('Registro Consumidor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            InputField(label: 'Nombre completo', controller: nombreCtrl),
            InputField(label: 'Región de compra', controller: regionCtrl),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (controller.validarCampos(
                  nombreCtrl.text,
                  regionCtrl.text,
                )) {
                  controller.guardarDatos(nombreCtrl.text, regionCtrl.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Consumidor registrado')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Completa todos los campos')),
                  );
                }
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
