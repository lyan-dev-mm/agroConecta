import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agroconecta/modules/auth/screens/registro/widgets/permission_prompt.dart';
import 'package:agroconecta/modules/auth/screens/registro/controllers/location_controller.dart';

class LocationPermissionScreen extends ConsumerWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(locationControllerProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF0E8646),
      body: PermissionPrompt(
        title: 'Permite acceso a tu ubicación',
        description:
            'Usamos tu ubicación para mejorar tu experiencia en la app.',
        icon: Icons.location_on,
        onGranted: () {
          controller.requestLocationPermission(() {
            Navigator.pushReplacementNamed(context, '/ubicacion');
          });
        },
      ),
    );
  }
}
