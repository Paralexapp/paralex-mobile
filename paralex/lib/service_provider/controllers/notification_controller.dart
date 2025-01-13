import 'dart:convert';
import 'package:get/get.dart';
import 'package:paralex/service_provider/controllers/user_choice_controller.dart';
import '../models/notification_model.dart';
import '../services/api_service.dart';

final userController = Get.find<UserChoiceController>();

class NotificationsController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var inboxMessages = <NotificationModel>[].obs;

  var unreadCount = 0.obs; // count for  notifications
  var inboxUnreadCount = 0.obs; // count for inbox messages

  final ApiService apiService = ApiService();

  Future<void> fetchNotifications({bool includeUserId = true}) async {
    try {
      String? userId = includeUserId ? userController.userIdToken.value : "null";
      late String endpoint;

      if (userController.selectedUserType.value == UserType.USER) {
        endpoint = 'api/notifications/get?userId=$userId';
      } else if (userController.selectedUserType.value == UserType.SERVICE_PROVIDER_LAWYER) {
        endpoint = 'api/notifications/get-lawyer-notification?userId=$userId';
      } else if (userController.selectedUserType.value == UserType.SERVICE_PROVIDER_RIDER) {
        endpoint = 'api/notifications/get-rider-notification?userId=$userId';
      }

      print('Fetching notifications from endpoint: $endpoint');

      // Fetch API response
      Map<String, dynamic> response = await apiService.getRequest(endpoint);
      print('Raw API response: $response');

      if (response.containsKey('data')) {
        print('Type of data: ${response['data'].runtimeType}');
        print('Content of data: ${response['data']}');

        var data = response['data'];
        if (data is String) {
          try {
            data = jsonDecode(data);
            print('Decoded data: $data');
          } catch (e) {
            print('Error decoding data: $e');
          }
        }

        if (data is List) {
          print('Processing notifications list: $data');

          List<NotificationModel> parsedNotifications = data.map((notification) {
            try {
              print('Parsing notification: $notification');

              List<int> createdAt = List<int>.from(notification['createdAt']);
              DateTime dateTime = DateTime(
                createdAt[0], createdAt[1], createdAt[2],
                createdAt[3], createdAt[4], createdAt[5],
              );

              String status = _extractStatusFromMessage(notification['message']);
              print('Parsed notification: dateTime=$dateTime, status=$status');

              return NotificationModel(
                message: notification['message'],
                dateTime: dateTime,
                status: status,
                title: notification['title'],
                notificationId: notification['id'],
                readInbox: notification['readInbox'],
              );
            } catch (e) {
              print('Error parsing notification: $e | Data: $notification');
              return null;
            }
          }).whereType<NotificationModel>().toList();

          if (includeUserId) {
            inboxMessages.value = parsedNotifications;
            updateInboxUnreadCount();
          } else {
            notifications.value = parsedNotifications;
            updateUnreadCount();
          }

          print('Final notifications list: ${notifications.value}');
        } else {
          print('Error: `data` is not a list after decoding. Found: $data');
        }
      } else {
        print('Error: Response does not contain `data` key.');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch notifications: $e',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void updateUnreadCount() {
    unreadCount.value = notifications.where((n) => !n.readInbox).length;
    print('Unread notifications count: ${unreadCount.value}');
  }

  void updateInboxUnreadCount() {
    inboxUnreadCount.value = inboxMessages.where((n) => !n.readInbox).length;
    print('Unread inbox messages count: ${inboxUnreadCount.value}');
  }

  String _extractStatusFromMessage(String message) {
    final List<String> validStatuses = [
      "delivered",
      "out for delivery",
      "canceled",
      "on hold"
    ];

    for (var status in validStatuses) {
      if (message.toLowerCase().contains(status.toLowerCase())) {
        return status;
      }
    }
    return "default";
  }
}

