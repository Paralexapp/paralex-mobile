class NotificationModel {
  final String title;
  final String message;
  final DateTime dateTime;
  final String status; // e.g., "delivered", "out for delivery"
  final String notificationId;
  final bool readInbox;

  NotificationModel({
    required this.message,
    required this.dateTime,
    required this.status,
    required this.title,
    required this.notificationId,
    required this.readInbox
  });
}
