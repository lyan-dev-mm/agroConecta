import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:agroconecta/modules/auth/screens/registro/widgets/input_field.dart';
import 'package:agroconecta/modules/auth/screens/registro/screens/selector_tipo_usuario.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import de provider
import 'package:agroconecta/modules/auth/providers/registro_usuario_provider.dart';

class FotoPerfilScreen extends ConsumerStatefulWidget {
  const FotoPerfilScreen({super.key});

  @override
  ConsumerState<FotoPerfilScreen> createState() => _FotoPerfilScreenState();
}

class _FotoPerfilScreenState extends ConsumerState<FotoPerfilScreen> {
  final formKey = GlobalKey<FormState>();
  final nombreCtrl = TextEditingController();
  final apellidosCtrl = TextEditingController();
  final generoCtrl = TextEditingController();
  File? foto;

  Future<void> seleccionarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        foto = File(pickedFile.path);
      });
      ref.read(registroUsuarioProvider.notifier).asignarFoto(foto!);
    }
  }

  void _continuar() {
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    ref
        .read(registroUsuarioProvider.notifier)
        .actualizarNombre(nombreCtrl.text.trim());
    ref
        .read(registroUsuarioProvider.notifier)
        .actualizarApellidos(apellidosCtrl.text.trim());
    ref
        .read(registroUsuarioProvider.notifier)
        .actualizarGenero(generoCtrl.text.trim());

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SelectorTipoUsuario()),
    );
  }

  @override
  void dispose() {
    nombreCtrl.dispose();
    apellidosCtrl.dispose();
    generoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usuario = ref.watch(registroUsuarioProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              'Seleccione una foto de perfil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: seleccionarFoto,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: foto != null
                    ? FileImage(foto!)
                    : usuario.foto != null
                    ? FileImage(usuario.foto!)
                    : const AssetImage('assets/images/default_avatar.png')
                          as ImageProvider,
                child: const Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Complementa tu información',
              style: TextStyle(fontSize: 16, fontFamily: 'Inter'),
            ),
            const SizedBox(height: 10),
            Form(
              key: formKey,
              child: Column(
                children: [
                  InputField(
                    label: 'Nombre',
                    controller: nombreCtrl,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'El nombre es obligatorio'
                        : null,
                  ),
                  InputField(
                    label: 'Apellidos',
                    controller: apellidosCtrl,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Los apellidos son obligatorios'
                        : null,
                  ),
                  InputField(
                    label: 'Género',
                    controller: generoCtrl,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Selecciona un género'
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Atrás'),
                ),
                ElevatedButton(
                  onPressed: _continuar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4BA43F),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Siguiente'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
