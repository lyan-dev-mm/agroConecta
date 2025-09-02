import 'package:flutter/material.dart';

class IndicesWidget extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String descripcion;

  const IndicesWidget({
    super.key,
    required this.icon,
    required this.titulo,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.9;

    return SizedBox(
      height: 140,
      width: cardWidth,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Icon(icon, size: 28, color: Colors.orange),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  descripcion,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
