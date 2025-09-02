import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String postId;
  final String userId;
  final String userName;
  final String text;
  final DateTime timestamp;
  final String? parentId;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.text,
    required this.timestamp,
    required this.parentId,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map, String id) {
    return CommentModel(
      id: id,
      postId: map['postId'],
      userId: map['userId'],
      userName: map['userName'],
      text: map['text'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      parentId: map['parentId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'userName': userName,
      'text': text,
      'timestamp': timestamp,
      'parentId': parentId,
    };
  }

  CommentModel copyWith({
    String? id,
    String? postId,
    String? userId,
    String? userName,
    String? text,
    DateTime? timestamp,
    String? parentId,
  }) {
    return CommentModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      parentId: parentId ?? this.parentId,
    );
  }
}
