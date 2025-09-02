import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agroconecta/models/comment_model.dart';

final comentariosProvider =
    StateNotifierProvider<ComentariosNotifier, List<CommentModel>>((ref) {
      return ComentariosNotifier();
    });

class ComentariosNotifier extends StateNotifier<List<CommentModel>> {
  ComentariosNotifier() : super([]);

  void agregarComentario(CommentModel nuevo) {
    state = [...state, nuevo];
  }

  void eliminarComentario(String id) {
    state = state.where((c) => c.id != id && c.parentId != id).toList();
  }

  void editarComentario(String id, String nuevoTexto) {
    state = [
      for (final c in state)
        if (c.id == id) c.copyWith(text: nuevoTexto) else c,
    ];
  }
}
