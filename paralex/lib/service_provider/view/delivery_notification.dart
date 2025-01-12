import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paralex/reusables/paints.dart';
import '../../reusables/fonts.dart';
import '../controllers/notification_controller.dart';
import '../models/notification_model.dart';
import 'notification_detail.dart';

class DeliveryNotification extends StatefulWidget {
  const DeliveryNotification({super.key, required this.appBarTitle});

  final String appBarTitle;

  @override
  State<DeliveryNotification> createState() => _DeliveryNotificationState();
}

class _DeliveryNotificationState extends State<DeliveryNotification> {
  final NotificationsController notificationsController = Get.find<NotificationsController>();

  @override
  void initState() {
    super.initState();
    bool includeUserId = widget.appBarTitle.toLowerCase() == "message";
    notificationsController.fetchNotifications(includeUserId: includeUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: widget.appBarTitle,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          bool includeUserId = widget.appBarTitle.toLowerCase() == "message";
          await notificationsController.fetchNotifications(
              includeUserId: includeUserId);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All ${widget.appBarTitle}s",
                    style: FontStyles.smallCapsIntro.copyWith(
                        fontSize: 18,
                        color: Color(0xFF21252C),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
                ],
              ),
            ),
            Expanded(child:
            Obx(() {
              final messages = widget.appBarTitle.toLowerCase() == "message"
                  ? notificationsController.inboxMessages
                  : notificationsController.notifications;
              if (messages.isEmpty) {
                return Center(child: Text('No ${widget.appBarTitle}s available'));
              }
              final reversedMessages = messages.reversed.toList();
              return ListView.builder(
                itemCount: reversedMessages.length,
                itemBuilder: (context, index) {
                  final notification = reversedMessages[index];
                  return NotificationWidget(
                    notification: notification,
                    appBarTitle: widget.appBarTitle,
                  );
                },
              );
            })

            ),
           ],
        ),
      ),
    );
  }
}
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  const CustomAppBar({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: PaintColors.paralexpurple,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: true,
      title: Text(
        appBarTitle,
        style:
            FontStyles.smallCapsIntro.copyWith(fontSize: 16, letterSpacing: 0),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}

class NotificationWidget extends StatelessWidget {
  final NotificationModel notification;
  final String appBarTitle;

  const NotificationWidget(
      {super.key, required this.notification, required this.appBarTitle});

  // Background color based on status
  Color _getBackgroundColor(String status) {
    switch (status) {
      case "delivered":
        return Color(0x25EF5DA8); // Light purple
      case "out for delivery":
        return Color(0x253B82F6); // Light blue
      case "canceled":
        return Color(0x25FF6666); // Light red
      case "on hold":
        return Color(0x25FFA500); // Light orange
      default:
        return Color(0xFFE0E0E0); // Default grey
    }
  }

  // Icon color based on status
  Color _getIconColor(String status) {
    switch (status) {
      case "delivered":
        return Color(0xFFEF5DA8); // Purple
      case "out for delivery":
        return Color(0xFF3B82F6); // Blue
      case "canceled":
        return Color(0xFFFF6666); // Red
      case "on hold":
        return Color(0xFFFFA500); // Orange
      default:
        return Color(0xFF888888); // Default grey
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Rendering NotificationWidget: message=${notification.message}, status=${notification.status}, dateTime=${notification.dateTime}');
    Color backgroundColor = _getBackgroundColor(notification.status);
    Color iconColor = _getIconColor(notification.status);

    String formattedDate = DateFormat('dd/MM/yy').format(notification.dateTime);
    String formattedTime = DateFormat('hh:mm a').format(notification.dateTime);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NotificationDetailScreen(
              title: notification.title,
              message: notification.message,
              notificationId: notification.notificationId,
              appBarTitle: appBarTitle,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFFF1F2F6), width: 2),
            bottom: BorderSide(color: Color(0xFFF1F2F6), width: 2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(13),
              ),
              child: SvgPicture.asset(
                "assets/images/delivery_icon.svg",
                colorFilter: ColorFilter.mode(
                  iconColor,
                  BlendMode.srcIn,
                ),
                width: 18,
                height: 20,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF21252C),
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        formattedTime,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF76889A),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF76889A),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            if (notification.readInbox)
              const Icon(
                Icons.done_all,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
