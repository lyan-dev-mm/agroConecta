import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuraciones',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Franklin Gothic Demi Cond',
            color: Color(0xFF4BA43F),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF4BA43F),
        elevation: 1,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSettingItem(
            context,
            icon: Icons.person,
            title: 'Editar perfil',
            onTap: () => Navigator.pushNamed(context, '/editProfile'),
          ),
          _buildSettingItem(
            context,
            icon: Icons.notifications,
            title: 'Notificaciones',
            onTap: () => Navigator.pushNamed(context, '/notifications'),
          ),
          _buildSettingItem(
            context,
            icon: Icons.language,
            title: 'Idioma',
            onTap: () => Navigator.pushNamed(context, '/language'),
          ),
          _buildSettingItem(
            context,
            icon: Icons.lock,
            title: 'Privacidad',
            onTap: () => Navigator.pushNamed(context, '/privacy'),
          ),
          _buildSettingItem(
            context,
            icon: Icons.help_outline,
            title: 'Ayuda',
            onTap: () => Navigator.pushNamed(context, '/help'),
          ),
          _buildSettingItem(
            context,
            icon: Icons.logout,
            title: 'Cerrar sesión',
            onTap: () {
              // Aquí podrías agregar lógica para cerrar sesión
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF4BA43F)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
