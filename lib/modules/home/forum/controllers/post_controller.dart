import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agroconecta/models/post_model.dart';

class PostController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Crear una nueva publicación con ID automático
  Future<void> createPost(PostModel post) async {
    final docRef = await _firestore.collection('posts').add(post.toJson());
    await docRef.update({'postId': docRef.id});
  }

  // Obtener publicación por ID
  Future<PostModel> getPostById(String postId) async {
    final doc = await _firestore.collection('posts').doc(postId).get();
    final data = doc.data();
    if (data != null) {
      return PostModel.fromDoc(doc);
    } else {
      throw Exception('Publicación no encontrada');
    }
  }

  // Obtener todas las publicaciones una sola vez
  Future<List<PostModel>> fetchAllPosts() async {
    final snapshot = await _firestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => PostModel.fromDoc(doc)).toList();
  }

  // Stream en tiempo real para el feed
  Stream<List<PostModel>> streamPosts() {
    return _firestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => PostModel.fromDoc(doc)).toList(),
        );
  }

  // Stream de una publicación específica
  Stream<PostModel> streamPostById(String postId) {
    return _firestore.collection('posts').doc(postId).snapshots().map((doc) {
      final data = doc.data();
      if (data != null) {
        return PostModel.fromDoc(doc);
      } else {
        throw Exception('Post no encontrado');
      }
    });
  }

  // Like / Dislike
  //Future<void> toggleLike(String postId, bool isLiked) async {
  //final ref = _firestore.collection('posts').doc(postId);
  //await ref.update({'reactions': FieldValue.increment(isLiked ? -1 : 1)});
  //}

  Future<void> toggleLike(String postId, String userId) async {
    final ref = _firestore.collection('posts').doc(postId);
    final doc = await ref.get();
    final data = doc.data();

    if (data == null) return;

    final likedBy = List<String>.from(data['likedBy'] ?? []);
    final isLiked = likedBy.contains(userId);

    if (isLiked) {
      likedBy.remove(userId);
      await ref.update({
        'reactions': FieldValue.increment(-1),
        'likedBy': likedBy,
      });
    } else {
      likedBy.add(userId);
      await ref.update({
        'reactions': FieldValue.increment(1),
        'likedBy': likedBy,
      });
    }
  }

  // Eliminar publicación
  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }

  // Actualizar publicación
  Future<void> updatePost(String postId, Map<String, dynamic> updates) async {
    await _firestore.collection('posts').doc(postId).update(updates);
  }

  Future<void> migrateLikedByField() async {
    final posts = await _firestore.collection('posts').get();
    for (final doc in posts.docs) {
      await doc.reference.set({'likedBy': []}, SetOptions(merge: true));
    }
  }
}
