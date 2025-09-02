import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  IconData _getIcon(String type) {
    switch (type) {
      case 'foro':
        return Icons.forum;
      case 'clima':
        return Icons.cloud;
      case 'plagas':
        return Icons.bug_report;
      case 'amistad':
        return Icons.person_add;
      case 'venta':
        return Icons.shopping_cart;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green.shade100,
        child: Icon(_getIcon(notification.type), color: Colors.green),
      ),
      title: Text(notification.description),
      subtitle: Text(
        '${notification.date.day}/${notification.date.month}/${notification.date.year} - ${notification.date.hour}:${notification.date.minute.toString().padLeft(2, '0')}',
      ),
      trailing: notification.isRead
          ? const Icon(Icons.check, color: Colors.grey)
          : const Icon(Icons.markunread, color: Colors.red),
      onTap: onTap,
    );
  }
}
