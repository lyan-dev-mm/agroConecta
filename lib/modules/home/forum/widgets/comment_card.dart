import 'package:flutter/material.dart';
import 'package:agroconecta/models/comment_model.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;
  final VoidCallback onResponder;

  const CommentCard({
    super.key,
    required this.comment,
    required this.onEditar,
    required this.onEliminar,
    required this.onResponder,
  });

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Justo ahora';
    if (diff.inMinutes < 60) return 'Hace ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Hace ${diff.inHours} h';
    return 'Hace ${diff.inDays} días';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(
              comment.userName.isNotEmpty ? comment.userName[0] : '?',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(comment.text, style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      _timeAgo(comment.timestamp),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: onResponder,
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const Text(
                        'Responder',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'editar') onEditar();
              if (value == 'eliminar') onEliminar();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'editar', child: Text('Editar')),
              const PopupMenuItem(value: 'eliminar', child: Text('Eliminar')),
            ],
          ),
        ],
      ),
    );
  }
}
