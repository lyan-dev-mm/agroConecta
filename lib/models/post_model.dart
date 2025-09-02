import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId;
  final String userId;
  final DateTime timestamp;
  final String userName;
  final String userImageUrl;
  final String userMood;
  final String postText;
  final String? postImageUrl;
  final int comments;
  final int reactions;
  final List<String> hashtags;
  final List<String> likedBy;

  PostModel({
    required this.postId,
    required this.userId,
    required this.timestamp,
    required this.userName,
    required this.userImageUrl,
    required this.userMood,
    required this.postText,
    this.postImageUrl,
    required this.comments,
    required this.reactions,
    required this.hashtags,
    required this.likedBy,
  });

  factory PostModel.fromDoc(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    return PostModel(
      postId: doc.id,
      userId: json['userId'] ?? '',
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      userName: json['userName'] ?? '',
      userImageUrl: json['userImageUrl'] ?? '',
      userMood: json['userMood'] ?? '',
      postText: json['postText'] ?? '',
      postImageUrl: json['postImageUrl'],
      comments: json['comments'] ?? 0,
      reactions: json['reactions'] ?? 0,
      hashtags: List<String>.from(json['hashtags'] ?? []),
      likedBy: List<String>.from(json['likedBy'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'timestamp': Timestamp.fromDate(timestamp),
    'userName': userName,
    'userImageUrl': userImageUrl,
    'userMood': userMood,
    'postText': postText,
    'postImageUrl': postImageUrl,
    'comments': comments,
    'reactions': reactions,
    'hashtags': hashtags,
    'likedBy': likedBy,
  };

  bool isLikedBy(String userId) => likedBy.contains(userId);
}
