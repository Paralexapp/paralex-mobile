class NotificationModel {
  final String message;
  final DateTime dateTime;
  final String status; // e.g., "delivered", "out for delivery"

  NotificationModel({
    required this.message,
    required this.dateTime,
    required this.status,
  });
}
