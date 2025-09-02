import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  // Instancia única
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> subirFotoPerfil(String uid, File imagen) async {
    final ref = _storage.ref().child('perfiles/$uid.jpg');
    await ref.putFile(imagen);
    return await ref.getDownloadURL();
  }

  Future<String> subirImagen(
    String folder,
    File imageFile, {
    String? uid,
  }) async {
    final fileName = uid != null
        ? '$uid.jpg'
        : '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = _storage.ref().child('$folder/$fileName');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }
}
