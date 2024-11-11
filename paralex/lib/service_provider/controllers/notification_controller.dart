import 'package:get/get.dart';
import '../models/notification_model.dart';


class NotificationsController extends GetxController {
  var notifications = <NotificationModel>[].obs;

  void addNotification(String message, String status) {
    final newNotification = NotificationModel(
      message: message,
      dateTime: DateTime.now(),
      status: status,
    );
    notifications.insert(0, newNotification); // Add to the start of the list
  }
}
