
class NotificationSettings {
  String?title;
  bool?isActive;
  List<NotificationListSettings>? notificationListSettings;

  NotificationSettings({  required this.title,required this.notificationListSettings,required this.isActive});
}

class NotificationListSettings {
  int?id;
  String? title ="";
  bool? isActive;

  NotificationListSettings({required this.title, required this.isActive});
}
