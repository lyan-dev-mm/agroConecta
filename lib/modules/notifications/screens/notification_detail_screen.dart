import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationDetailScreen extends StatelessWidget {
  final NotificationModel notification;

  const NotificationDetailScreen({super.key, required this.notification});

  Widget _buildContent(String type) {
    switch (type) {
      case 'foro':
        return const Text('Detalles del comentario en el foro...');
      case 'clima':
        return const Text('Pronóstico y alertas meteorológicas...');
      case 'plagas':
        return const Text('Información sobre la plaga detectada...');
      case 'actividades':
        return const Text('Descripción de la actividad programada...');
      case 'amistad':
        return const Text('Perfil del usuario que te envió la solicitud...');
      case 'venta':
        return const Text('Detalles de la transacción de tu producto...');
      case 'capacitacion':
        return const Text('Contenido del curso o taller...');
      case 'invitacion':
        return const Text('Información del amigo que te invitó...');
      case 'calendario':
        return const Text('Eventos próximos en tu calendario...');
      default:
        return const Text('Información general de la notificación.');
    }
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'foro':
        return Icons.forum;
      case 'clima':
        return Icons.cloud;
      case 'plagas':
        return Icons.bug_report;
      case 'actividades':
        return Icons.event;
      case 'amistad':
        return Icons.person_add;
      case 'venta':
        return Icons.shopping_cart;
      case 'capacitacion':
        return Icons.school;
      case 'invitacion':
        return Icons.group;
      case 'calendario':
        return Icons.calendar_today;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle: ${notification.type.toUpperCase()}'),
        backgroundColor: const Color(0xFF4BA43F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(_getIcon(notification.type), size: 40, color: Colors.green),
            const SizedBox(height: 16),
            Text(
              notification.description,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Fecha: ${notification.date.day}/${notification.date.month}/${notification.date.year}',
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(height: 32),
            _buildContent(notification.type),
          ],
        ),
      ),
    );
  }
}
