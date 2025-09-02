import 'package:flutter/material.dart';
//import 'package:agroconecta/models/post_model.dart';

class LocalPostCard extends StatelessWidget {
  const LocalPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    const double contentLeft = 48; // Alineado con el nombre del usuario
    const double contentMaxWidth = 300;
    const double horizontalContentPadding = 10;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 19), // Más aire inferior
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 Encabezado con avatar + nombre + estado + tiempo
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/736x/22/01/e9/2201e9c25c8c10690ee4ca14354b088d.jpg',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Juan Pérez',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '🌱 Optimista',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Tiempo alineado perfectamente con el nombre
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ' Hace 5 min',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // 📄 Contenido (texto, imagen, íconos) bien alineado
            Padding(
              padding: const EdgeInsets.only(left: contentLeft),
              child: Container(
                constraints: const BoxConstraints(maxWidth: contentMaxWidth),
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalContentPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hoy sembramos maíz y el clima estuvo perfecto 🌞. ¡Avanzamos con buen ritmo!',
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://i.pinimg.com/1200x/e2/a9/b0/e2a9b06dccc5a777a0f6a986eb9d68fa.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.favorite_border, color: Colors.grey[600]),
                        const SizedBox(width: 6),
                        const Text('23'),
                        const SizedBox(width: 20),
                        Icon(Icons.comment, color: Colors.grey[600]),
                        const SizedBox(width: 6),
                        const Text('5'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
