import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agroconecta/models/comment_model.dart';

class FirestoreService {
  // Instancia unica
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirestoreService._internal();

  // Método get
  FirebaseFirestore get db => _db;

  Future<void> guardarDatosAgricultor(
    String uid,
    Map<String, dynamic> datos,
  ) async {
    try {
      await _db.collection('agricultores').doc(uid).set({
        ...datos,
        'perfilCompleto': true,
        'fechaRegistro': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print('Perfil del agricultor creado con éxito');
    } catch (e) {
      print('Error guardando perfil: $e');
    }
  }

  Future<DocumentSnapshot> obtenerDatosUsuario(String uid) async {
    return await _db.collection('agricultores').doc(uid).get();
  }

  Future<void> guardarComentario(CommentModel comentario) async {
    await _db
        .collection('posts')
        .doc(comentario.postId)
        .collection('comentarios')
        .add(comentario.toMap());

    await _db.collection('posts').doc(comentario.postId).update({
      'comments': FieldValue.increment(1),
    });
  }

  Stream<List<CommentModel>> obtenerComentarios(String postId) {
    return _db
        .collection('posts')
        .doc(postId)
        .collection('comentarios')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CommentModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> eliminarComentario(String postId, String commentId) async {
    await _db
        .collection('posts')
        .doc(postId)
        .collection('comentarios')
        .doc(commentId)
        .delete();
  }

  Future<void> actualizarComentario(CommentModel comentario) async {
    await _db
        .collection('posts')
        .doc(comentario.postId)
        .collection('comentarios')
        .doc(comentario.id)
        .update(comentario.toMap());
  }
}
