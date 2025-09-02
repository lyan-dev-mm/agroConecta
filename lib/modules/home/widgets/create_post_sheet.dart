import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:agroconecta/services/post_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePostSheet extends StatefulWidget {
  const CreatePostSheet({super.key});

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<CreatePostSheet> {
  final TextEditingController _contentController = TextEditingController();
  String? _mood;
  String? _location;
  XFile? _image;
  bool _loading = false;

  final _postService = PostService();
  final List<String> moods = ['🙂', '😐', '😞', '💪', '😴'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = picked);
  }

  Future<void> _submitPost({required bool asDraft}) async {
    if (_contentController.text.trim().isEmpty) return;

    setState(() => _loading = true);

    await _postService.uploadPost(
      userId: 'usuario123',
      username: 'Agricultor Ejemplar',
      content: _contentController.text.trim(),
      mood: _mood,
      location: _location,
      image: _image,
    );

    // Si manejas drafts por separado, lo guardarías con bandera en Firestore
    if (asDraft) {
      await FirebaseFirestore.instance.collection('posts').add({
        'isDraft': true,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    setState(() => _loading = false);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(asDraft ? 'Borrador guardado' : '¡Publicado!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.shade300, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Center(child: Text('Sin imagen')),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                  icon: const Icon(Icons.image, color: Colors.green),
                  onPressed: _pickImage,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Text('Estado de ánimo'),
          Wrap(
            spacing: 10,
            children: moods.map((m) {
              return ChoiceChip(
                label: Text(m),
                selected: _mood == m,
                onSelected: (_) => setState(() => _mood = m),
                selectedColor: Colors.green.shade200,
              );
            }).toList(),
          ),

          const SizedBox(height: 16),
          TextField(
            controller: _contentController,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Mensaje',
              hintText:
                  'Comparte lo que está pasando... Usa #temas para que los demás te encuentren',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 24),
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _submitPost(asDraft: true),
                      icon: const Icon(Icons.save_alt),
                      label: const Text('Guardar borrador'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _submitPost(asDraft: false),
                      icon: const Icon(Icons.send),
                      label: const Text('Publicar'),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
