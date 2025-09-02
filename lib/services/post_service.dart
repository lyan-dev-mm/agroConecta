import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostService {
  Future<void> uploadPost({
    required String userId,
    required String username,
    required String content,
    String? mood,
    String? location,
    XFile? image,
  }) async {
    final hashtags = _extractHashtags(content);
    String? imageUrl;

    // Subir imagen si existe
    if (image != null) {
      final ref = FirebaseStorage.instance.ref(
        'posts/${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await ref.putFile(File(image.path));
      imageUrl = await ref.getDownloadURL();
    }

    // Crear documento en Firestore
    final post = {
      'userId': userId,
      'username': username,
      'content': content,
      'hashtags': hashtags,
      'mood': mood,
      'location': location,
      'imageUrl': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance.collection('posts').add(post);
  }

  List<String> _extractHashtags(String text) {
    final regex = RegExp(r"#(\w+)");
    return regex.allMatches(text).map((m) => m.group(1)!).toList();
  }
}
