class ReplyModel {
  final String id;
  final String postId; //
  final String commentId; //
  final String userId;
  final String userName;
  final String text;
  final DateTime timestamp;
  final List<String> likes;

  ReplyModel({
    required this.id,
    required this.postId,
    required this.commentId,
    required this.userId,
    required this.userName,
    required this.text,
    required this.timestamp,
    required this.likes,
  });

  Map<String, dynamic> toMap() => {
    'postId': postId,
    'commentId': commentId,
    'userId': userId,
    'userName': userName,
    'text': text,
    'timestamp': timestamp.toIso8601String(),
    'likes': likes,
  };

  factory ReplyModel.fromMap(Map<String, dynamic> map) => ReplyModel(
    id: map['id'] ?? '',
    postId: map['postId'] ?? '',
    commentId: map['commentId'] ?? '',
    userId: map['userId'] ?? '',
    userName: map['userName'] ?? '',
    text: map['text'] ?? '',
    timestamp: DateTime.parse(
      map['timestamp'] ?? DateTime.now().toIso8601String(),
    ),
    likes: List<String>.from(map['likes'] ?? []),
  );
}
