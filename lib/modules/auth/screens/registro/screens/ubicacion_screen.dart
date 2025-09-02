import 'package:agroconecta/modules/auth/providers/registro_usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:agroconecta/modules/auth/screens/registro/screens/foto_perfil_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/input_field.dart';
import 'package:agroconecta/services/gps_service.dart';
import 'package:agroconecta/services/geocoding_service.dart';

class UbicacionScreen extends ConsumerStatefulWidget {
  const UbicacionScreen({super.key});

  @override
  ConsumerState<UbicacionScreen> createState() => _UbicacionScreenState();
}

class _UbicacionScreenState extends ConsumerState<UbicacionScreen> {
  final formKey = GlobalKey<FormState>();
  final estadoCtrl = TextEditingController();
  final municipioCtrl = TextEditingController();
  final comunidadCtrl = TextEditingController();

  double? latitud;
  double? longitud;
  double? altitud;

  @override
  void initState() {
    super.initState();
    _precargarUbicacion();
  }

  Future<void> _precargarUbicacion() async {
    final posicion = await GpsService().obtenerPosicionActual();
    if (posicion != null) {
      latitud = posicion.latitude;
      longitud = posicion.longitude;
      altitud = posicion.altitude;

      final datos = await GeocodingService().reverseGeocode(
        latitud!,
        longitud!,
      );
      estadoCtrl.text = datos['estado'] ?? '';
      municipioCtrl.text = datos['municipio'] ?? '';
      comunidadCtrl.text = datos['comunidad'] ?? '';
    }
  }

  void _continuar() {
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    // Actualiza el estado global del usuario
    ref
        .read(registroUsuarioProvider.notifier)
        .actualizarDireccion(
          estadoCtrl.text.trim(),
          municipioCtrl.text.trim(),
          comunidadCtrl.text.trim(),
        );

    ref
        .read(registroUsuarioProvider.notifier)
        .actualizarUbicacion(latitud ?? 0, longitud ?? 0, altitud ?? 0);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FotoPerfilScreen()),
    );
  }

  @override
  void dispose() {
    estadoCtrl.dispose();
    municipioCtrl.dispose();
    comunidadCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación', style: TextStyle(fontFamily: 'Inter')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/encabezado-selector.png',
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Detectamos tu ubicación automáticamente. Por favor confirma los siguientes datos.',
                style: TextStyle(fontSize: 18, fontFamily: 'Inter'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    InputField(
                      label: 'Estado',
                      controller: estadoCtrl,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'El estado es obligatorio'
                          : null,
                    ),
                    InputField(
                      label: 'Municipio',
                      controller: municipioCtrl,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'El municipio es obligatorio'
                          : null,
                    ),
                    InputField(
                      label: 'Comunidad',
                      controller: comunidadCtrl,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'La comunidad es obligatoria'
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4BA43F),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _continuar,
                  child: const Text(
                    'Siguiente',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
