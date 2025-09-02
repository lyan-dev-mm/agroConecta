import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod
import 'package:provider/provider.dart'
    as classic_provider; //  alias para evitar conflicto
// Screens
import 'package:agroconecta/modules/home/screens/home_screen.dart';
import 'package:agroconecta/modules/activities/screens/agenda_screen.dart';
import 'package:agroconecta/modules/auth/screens/login_screen.dart';
import 'package:agroconecta/modules/marketplace/screens/marketplace_screen.dart';
import 'package:agroconecta/modules/profile/screens/profile_screen.dart';
import 'package:agroconecta/modules/activities/screens/detectar_plaga_screen.dart';
import 'package:agroconecta/modules/activities/screens/camara_plaga_screen.dart';
import 'package:agroconecta/modules/activities/screens/trabajo_equipo_screen.dart';
import 'package:agroconecta/modules/home/screens/capacitacion_screen.dart';
import 'package:agroconecta/modules/home/screens/red_apoyo.dart';
import 'package:agroconecta/modules/settings/screens/settings_screen.dart';
import 'package:agroconecta/modules/auth/screens/registro/screens/location_permission_screen.dart';

// Notificacion
import 'package:agroconecta/modules/notifications/screens/local_notifications_screen.dart';

// Providers
import 'package:agroconecta/modules/home/providers/search_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: classic_provider.MultiProvider(
        providers: [
          classic_provider.ChangeNotifierProvider<SearchProvider>(
            create: (_) => SearchProvider(),
          ),
        ],
        child: const AgroConectaApp(),
      ),
    ),
  );
}

class AgroConectaApp extends StatelessWidget {
  const AgroConectaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroConect@',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF4BA43F)),
        useMaterial3: true,
      ),
      home: const LocationPermissionScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/marketplace': (context) => const MarketplaceScreen(),
        '/activities': (context) => const AgendaScreen(),
        '/notifications': (context) => const LocalNotificationsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/login': (context) => const LoginScreen(),
        '/detectar': (context) => const DetectarPlagaScreen(),
        '/camara': (context) => const CamaraPlagaScreen(),
        '/equipo': (context) => const TrabajoEnEquipoScreen(),
        '/capacitacion': (context) => const CapacitacionScreen(),
        '/red': (context) => const RedApoyoScreen(),
      },
    );
  }
}
