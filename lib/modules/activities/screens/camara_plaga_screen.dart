import 'package:flutter/material.dart';

class CamaraPlagaScreen extends StatelessWidget {
  const CamaraPlagaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tomar Foto')),
      body: Stack(
        children: [
          // Simulación de cámara
          Container(color: Colors.black),

          // 📸 Controles
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.flash_on, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.photo_library, color: Colors.white),
                  onPressed: () {},
                ),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {},
                  child: const Icon(Icons.camera, color: Colors.black),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.analytics_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Aquí podrías mostrar resultados
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Procesando imagen...')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
