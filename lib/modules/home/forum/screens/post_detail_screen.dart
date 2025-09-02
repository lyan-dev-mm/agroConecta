import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agroconecta/models/comment_model.dart';
import 'package:agroconecta/modules/home/providers/post_provider.dart';
import 'package:agroconecta/modules/home/forum/widgets/comment_card.dart';
import 'package:agroconecta/modules/home/providers/comment_provider.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  final String postId;
  final String userId;
  final String userName;

  const PostDetailScreen({
    super.key,
    required this.postId,
    required this.userId,
    required this.userName,
  });

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  CommentModel? _comentarioEditado;

  void _enviarComentario() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final provider = ref.read(postProvider);

    if (_comentarioEditado != null && _comentarioEditado!.id.isNotEmpty) {
      final actualizado = CommentModel(
        id: _comentarioEditado!.id,
        postId: widget.postId,
        userId: widget.userId,
        userName: widget.userName,
        text: text,
        timestamp: DateTime.now(),
        parentId: _comentarioEditado!.parentId,
      );
      await provider.editarComentario(actualizado);
    } else {
      await provider.agregarComentario(
        postId: widget.postId,
        userId: widget.userId,
        userName: widget.userName,
        text: text,
        parentId: _comentarioEditado?.parentId,
      );
    }

    setState(() {
      _controller.clear();
      _comentarioEditado = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(postProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Comentarios')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<CommentModel>>(
              stream: provider.obtenerComentariosStream(widget.postId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final comentarios = snapshot.data!;
                final principales = comentarios
                    .where((c) => c.parentId == null)
                    .toList();

                if (principales.isEmpty) {
                  return const Center(
                    child: Text('Sé el primero en comentar.'),
                  );
                }

                return ListView(
                  children: principales.map((comentario) {
                    final respuestas = comentarios
                        .where((r) => r.parentId == comentario.id)
                        .toList();

                    return AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommentCard(
                            comment: comentario,
                            onEditar: () {
                              setState(() {
                                _controller.text = comentario.text;
                                _comentarioEditado = comentario;
                              });
                            },
                            onEliminar: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('¿Eliminar comentario?'),
                                  content: const Text(
                                    'Esta acción no se puede deshacer.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text(
                                        'Eliminar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                ref
                                    .read(comentariosProvider.notifier)
                                    .eliminarComentario(comentario.id);
                              }
                            },
                            onResponder: () {
                              setState(() {
                                _controller.clear();
                                _comentarioEditado = CommentModel(
                                  id: '',
                                  postId: widget.postId,
                                  userId: widget.userId,
                                  userName: widget.userName,
                                  text: '',
                                  timestamp: DateTime.now(),
                                  parentId: comentario.id,
                                );
                              });
                            },
                          ),
                          ...respuestas.map(
                            (respuesta) => Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: CommentCard(
                                comment: respuesta,
                                onEditar: () {
                                  setState(() {
                                    _controller.text = respuesta.text;
                                    _comentarioEditado = respuesta;
                                  });
                                },
                                onEliminar: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('¿Eliminar respuesta?'),
                                      content: const Text(
                                        'Esta acción no se puede deshacer.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: const Text(
                                            'Eliminar',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirm == true) {
                                    ref
                                        .read(comentariosProvider.notifier)
                                        .eliminarComentario(respuesta.id);
                                  }
                                },
                                onResponder: () {
                                  setState(() {
                                    _controller.clear();
                                    _comentarioEditado = CommentModel(
                                      id: '',
                                      postId: widget.postId,
                                      userId: widget.userId,
                                      userName: widget.userName,
                                      text: '',
                                      timestamp: DateTime.now(),
                                      parentId: respuesta.id,
                                    );
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          //const Divider(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: _comentarioEditado != null
                          ? (_comentarioEditado!.id.isEmpty
                                ? 'Respondiendo...'
                                : 'Editando comentario...')
                          : 'Escribe un comentario...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _comentarioEditado != null ? Icons.check : Icons.send,
                  ),
                  onPressed: _enviarComentario,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
