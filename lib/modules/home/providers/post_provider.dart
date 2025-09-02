import 'package:agroconecta/modules/home/forum/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:agroconecta/models/post_model.dart';
import 'package:agroconecta/services/firestore_service.dart';
import 'package:agroconecta/models/comment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostProvider with ChangeNotifier {
  final PostController _controller = PostController();
  final FirestoreService _firestoreService = FirestoreService();
  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;

  void init() {
    PostController().streamPosts().listen((newPosts) {
      _posts = newPosts;
      notifyListeners();
    });
  }

  Future<void> createPost(PostModel post) async {
    await _controller.createPost(post);
  }

  Future<void> agregarComentario({
    required String postId,
    required String userId,
    required String userName,
    required String text,
    String? parentId,
  }) async {
    final comentario = CommentModel(
      id: '',
      postId: postId,
      userId: userId,
      userName: userName,
      text: text,
      timestamp: DateTime.now(),
      parentId: parentId,
    );

    await _firestoreService.guardarComentario(comentario);
    notifyListeners();
  }

  Stream<List<CommentModel>> obtenerComentariosStream(String postId) {
    return _firestoreService.obtenerComentarios(postId);
  }

  Future<void> eliminarComentario(String postId, String commentId) async {
    await _firestoreService.eliminarComentario(postId, commentId);
    notifyListeners();
  }

  Future<void> editarComentario(CommentModel comentario) async {
    await _firestoreService.actualizarComentario(comentario);
    notifyListeners();
  }
}

final postProvider = ChangeNotifierProvider<PostProvider>((ref) {
  final provider = PostProvider();
  provider.init();
  return provider;
});
