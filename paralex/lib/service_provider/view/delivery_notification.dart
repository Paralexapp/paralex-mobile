import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paralax/reusables/paints.dart';
import '../../reusables/fonts.dart';
import '../../routes/navs.dart';
import '../controllers/notification_controller.dart';
import '../models/notification_model.dart';

class DeliveryNotification extends StatelessWidget {
  final NotificationsController notificationsController =
      Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Notifications",
                  style: FontStyles.smallCapsIntro.copyWith(
                      fontSize: 18,
                      color: Color(0xFF21252C),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0),
                ),
                IconButton(
                    onPressed: () {
                      Get.toNamed(Nav.deliveryInfo);
                    },
                    icon: Icon(Icons.tune)),
              ],
            ),
          ),
          Text("The Buttom was only added for test purpose, click to add notifications.  Click the button far right of All Notification to view subsequent screens."),
          Expanded(
            child: Obx(() {
              // Observe the notifications list for changes
              return ListView.builder(
                itemCount: notificationsController.notifications.length,
                itemBuilder: (context, index) {
                  final notification =
                      notificationsController.notifications[index];
                  return NotificationWidget(notification: notification);
                },
              );
            }),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notificationsController.addNotification(
              "Your parcel has been successfully delivered", "delivered");
          notificationsController.addNotification(
              "Your package is out for delivery and will arrive today",
              "out for delivery");
          notificationsController.addNotification(
              "Due to server problem your booking got canceled", "canceled");
          notificationsController.addNotification(
              "Your shipment is on hold due to an incomplete address",
              "on hold");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: PaintColors.paralaxpurple,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: true,
      title: Text(
        'Notifications',
        style: FontStyles.smallCapsIntro.copyWith(
            fontSize: 16, letterSpacing: 0),
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

  const NotificationWidget({super.key, required this.notification});

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
        return Color(0xFFE0E0E0); // Default grey color
    }
  }

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
        return Color(0xFF888888); // Default grey color
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yy').format(notification.dateTime);
    String formattedTime = DateFormat('hh:mm a').format(notification.dateTime);

    return Container(
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
              color: _getBackgroundColor(notification.status),
              borderRadius: BorderRadius.circular(13),
            ),
            child: SvgPicture.asset(
              "assets/images/delivery_icon.svg",
              colorFilter: ColorFilter.mode(
                _getIconColor(notification.status),
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
                  notification.message,
                  style: FontStyles.smallCapsIntro.copyWith(
                      fontSize: 16,
                      color: Color(0xFF21252C),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0),
                  softWrap: true,
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      formattedTime,
                      style: FontStyles.smallCapsIntro.copyWith(
                        fontSize: 14,
                        color: Color(0xFF76889A),
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      formattedDate,
                      style: FontStyles.smallCapsIntro.copyWith(
                        fontSize: 14,
                        color: Color(0xFF76889A),
                        letterSpacing: 0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}
