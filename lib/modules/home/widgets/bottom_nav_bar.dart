import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Logica de navegación

    switch (index) {
      case 0:
        // Navega a Home
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        // Navega a Home
        Navigator.pushNamed(context, '/marketplace');
        break;
      case 2:
        // Navega a Home
        Navigator.pushNamed(context, '/activities');
        break;
      case 3:
        // Navega a Home
        Navigator.pushNamed(context, '/notifications');
        break;
      case 4:
        // Navega a Home
        Navigator.pushNamed(context, '/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex, // Cambiar dinámicamente si navegas
      onTap: _onItemTapped,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: const Color(0xFF4BA43F),
      unselectedItemColor: Colors.grey,
      selectedIconTheme: const IconThemeData(size: 26),
      unselectedIconTheme: const IconThemeData(size: 26),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Tienda'),
        BottomNavigationBarItem(
          icon: Icon(Icons.app_registration_rounded),
          label: 'Calendario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Alertas',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
      ],
    );
  }
}
