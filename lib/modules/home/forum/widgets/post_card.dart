import 'package:flutter/material.dart';
import 'package:agroconecta/models/post_model.dart';
import 'package:agroconecta/modules/home/forum/controllers/post_controller.dart';
import 'package:agroconecta/modules/home/forum/screens/post_detail_screen.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final String currentUserId;

  const PostCard({super.key, required this.post, required this.currentUserId});

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Justo ahora';
    if (diff.inMinutes < 60) return 'Hace ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Hace ${diff.inHours} h';
    return 'Hace ${diff.inDays} días';
  }

  @override
  Widget build(BuildContext context) {
    final isLiked = post.isLikedBy(currentUserId);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(post.userImageUrl),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            post.userMood,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _timeAgo(post.timestamp),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Contenido
            Padding(
              padding: const EdgeInsets.only(left: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.postText,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                  if (post.postImageUrl != null) ...[
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        post.postImageUrl!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey[600],
                        ),
                        onPressed: () async {
                          await PostController().toggleLike(
                            post.postId,
                            currentUserId,
                          );
                        },
                      ),
                      const SizedBox(width: 6),
                      Text('${post.reactions}'),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.comment, color: Colors.grey),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PostDetailScreen(
                                postId: post.postId,
                                userId: currentUserId,
                                userName: post.userName,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 6),
                      Text('${post.comments}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
