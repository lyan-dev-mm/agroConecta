import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../widgets/notification_title.dart';

class LocalNotificationsScreen extends StatefulWidget {
  const LocalNotificationsScreen({super.key});

  @override
  State<LocalNotificationsScreen> createState() =>
      _LocalNotificationsScreenState();
}

class _LocalNotificationsScreenState extends State<LocalNotificationsScreen> {
  String? selectedType;

  List<NotificationModel> notifications = [
    NotificationModel(
      type: 'foro',
      description: 'Nuevo comentario en el foro',
      date: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    NotificationModel(
      type: 'clima',
      description: 'Alerta de tormenta',
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationModel(
      type: 'plagas',
      description: 'Plaga detectada',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationModel(
      type: 'amistad',
      description: 'Solicitud de amistad de Juan',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    NotificationModel(
      type: 'venta',
      description: 'Producto vendido',
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  void _markAsRead(NotificationModel notification) {
    setState(() {
      notification.isRead = true;
    });
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        final types = ['foro', 'clima', 'plagas', 'amistad', 'venta'];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.clear),
              title: const Text('Mostrar todas'),
              onTap: () {
                setState(() => selectedType = null);
                Navigator.pop(context);
              },
            ),
            ...types.map(
              (type) => ListTile(
                leading: const Icon(Icons.filter_alt),
                title: Text(type.toUpperCase()),
                onTap: () {
                  setState(() => selectedType = type);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = selectedType == null
        ? notifications
        : notifications.where((n) => n.type == selectedType).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notificaciones',
          style: TextStyle(
            fontFamily: 'Franklin Gothic Demi Cond',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4BA43F),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.green),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final notification = filtered[index];
          return NotificationTile(
            notification: notification,
            onTap: () => _markAsRead(notification),
          );
        },
      ),
    );
  }
}
