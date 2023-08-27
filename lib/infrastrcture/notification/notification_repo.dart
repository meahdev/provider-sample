
import '../../domain/notification/notification_settings.dart';

class NotificationRepo{
  List<NotificationSettings> mNotification = [];


  List<NotificationSettings> getNotification(){
    mNotification = [
      NotificationSettings(
          title: "Email Notification",
          isActive: false,
          notificationListSettings: [
            NotificationListSettings(title: "Order Updates", isActive: false),
            NotificationListSettings(
                title: "Shipping Updates", isActive: false),
            NotificationListSettings(title: "Promotions", isActive: false),
            NotificationListSettings(title: "Offers", isActive: false),
            NotificationListSettings(title: "News", isActive: false),
            NotificationListSettings(title: "Messages", isActive: false),
            NotificationListSettings(title: "New Arrivals", isActive: false)
          ]),
      NotificationSettings(
          title: "Push Notification",
          isActive: false,
          notificationListSettings: [
            NotificationListSettings(title: "Push Updates", isActive: false),
            NotificationListSettings(title: "Push Updates", isActive: false),
            NotificationListSettings(title: "Push Promotions", isActive: false),
          ]),
      NotificationSettings(
          title: "Notification at Night",
          isActive: false,
          notificationListSettings: [
            NotificationListSettings(
                title: "Notification Offers", isActive: false),
            NotificationListSettings(
                title: "Notification News", isActive: false),
            NotificationListSettings(
                title: "Notification Messages", isActive: false)
          ]),
    ];
    return mNotification;
  }
}