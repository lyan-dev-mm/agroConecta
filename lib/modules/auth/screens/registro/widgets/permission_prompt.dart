import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionPrompt extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onGranted;

  const PermissionPrompt({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onGranted,
  });

  Future<void> _requestPermission(BuildContext context) async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      onGranted();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('¡Permiso concedido!')));
    } else if (status.isDenied) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Permiso denegado')));
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => _requestPermission(context),
              icon: const Icon(Icons.lock_open),
              label: const Text('Permitir acceso'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0E8646),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
