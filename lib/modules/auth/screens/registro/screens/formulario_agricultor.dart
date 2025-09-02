import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import de provider
import 'package:agroconecta/modules/auth/providers/registro_usuario_provider.dart';
import 'package:agroconecta/modules/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agroconecta/modules/auth/validators/usuario_registro_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgricultorRegister extends ConsumerStatefulWidget {
  const AgricultorRegister({super.key});

  @override
  ConsumerState<AgricultorRegister> createState() => _AgricultorRegisterState();
}

class _AgricultorRegisterState extends ConsumerState<AgricultorRegister> {
  final formKey = GlobalKey<FormState>();
  final tamFincaCtrl = TextEditingController();
  final tecCulCtrl = TextEditingController();

  String cultivoSeleccionado = "Maíz";
  final List<String> listaCultivos = ['Maíz', 'Naranja', 'Mandarina'];

  @override
  void dispose() {
    tamFincaCtrl.dispose();
    tecCulCtrl.dispose();
    super.dispose();
  }

  Future<void> _registrarUsuario() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Completa todos los datos")));
      return;
    }

    // Actualiza el estado global
    ref
        .read(registroUsuarioProvider.notifier)
        .actualizarTamParcela(tamFincaCtrl.text.trim());
    ref
        .read(registroUsuarioProvider.notifier)
        .actualizarTecnica(tecCulCtrl.text.trim());
    ref
        .read(registroUsuarioProvider.notifier)
        .actualizarCultivo(cultivoSeleccionado);

    final usuario = ref.read(registroUsuarioProvider);
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No hay usuario autenticado")),
      );
      return;
    }

    try {
      await ref
          .read(registroUsuarioProvider.notifier)
          .guardarUsuarioEnFirestore();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('usuarioRegistrado', true);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error al registrar usuario: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ficha del Agricultor',
          style: TextStyle(fontFamily: 'Inter'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
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
                const SizedBox(height: 5),
                const Text(
                  'Ingrese los siguientes datos:',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Inter',
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                InputField(
                  label: 'Tamaño de la finca',
                  controller: tamFincaCtrl,
                  validator: UsuarioRegistroValidator.validarTamParcela,
                ),
                InputField(
                  label: 'Técnica de cultivo',
                  controller: tecCulCtrl,
                  validator: UsuarioRegistroValidator.validarTecnicaCultivo,
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: cultivoSeleccionado,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  items: listaCultivos.map((String valor) {
                    return DropdownMenuItem(value: valor, child: Text(valor));
                  }).toList(),
                  onChanged: (String? nuevoValor) {
                    setState(() {
                      cultivoSeleccionado = nuevoValor ?? '';
                    });
                  },
                  validator: UsuarioRegistroValidator.validarCultivo,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4BA43F),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: _registrarUsuario,
                    child: const Text(
                      'Registrar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
