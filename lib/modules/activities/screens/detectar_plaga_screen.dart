import 'package:flutter/material.dart';
import 'package:agroconecta/modules/activities/widgets/indices_widget.dart';

class DetectarPlagaScreen extends StatelessWidget {
  const DetectarPlagaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detección de Plagas')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟦 Widget de clima
            const IndicesWidget(
              icon: Icons.wb_sunny_outlined,
              titulo: 'Hoy, 20 de junio',
              descripcion: 'Totalmente despejado\nBuen momento para sembrar 🌱',
            ),

            const SizedBox(height: 16),

            // 🟥 Widget de radiación
            const IndicesWidget(
              icon: Icons.bolt_outlined,
              titulo: 'Nivel de radiación',
              descripcion:
                  'Índice UV: 3 (Moderado)\nPuedes permanecer en el exterior sin protección por un tiempo limitado.',
            ),

            const SizedBox(height: 24),

            // 🌱 Selector de planta
            const Text(
              'Selecciona el tipo de planta:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'Maíz', child: Text('Maíz')),
                DropdownMenuItem(
                  value: 'Caña de azúcar',
                  child: Text('Caña de azúcar'),
                ),
                DropdownMenuItem(value: 'Tomate', child: Text('Tomate')),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tipo de planta',
              ),
            ),

            const SizedBox(height: 32),

            // 📷 Botón para abrir cámara
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Tomar foto para detectar plaga'),
                onPressed: () {
                  Navigator.pushNamed(context, '/camara');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
