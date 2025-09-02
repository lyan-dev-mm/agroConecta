class NotificationModel {
  final String type;
  final String description;
  final DateTime date;
  bool isRead;

  NotificationModel({
    required this.type,
    required this.description,
    required this.date,
    this.isRead = false,
  });
}
