class ContactModel {
  final String userId;
  final String name;
  final String profileImageUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isUnread;
  final bool isFavorite;

  ContactModel({
    required this.userId,
    required this.name,
    required this.profileImageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    this.isUnread = false,
    this.isFavorite = false,
  });
}
