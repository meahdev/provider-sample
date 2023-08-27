import 'package:flutter/material.dart';
import 'package:flutter_provider_test/domain/notification/notification_settings.dart';
import 'package:flutter_provider_test/infrastrcture/notification/notification_repo.dart';
import 'package:provider/provider.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationSettings> mNotification = [];
  bool isHasItems = false;
  int selectedParent = 0;
  NotificationRepo notificationRepo;

  NotificationProvider(this.notificationRepo);

  getNotificationList() {
    mNotification = notificationRepo.getNotification();
    notifyListeners();
  }

  itemsIn(bool value) {
    isHasItems = value;
    notifyListeners();
  }

  clearValues() {
    for (var i in mNotification) {
      i.isActive = false;
    }
    notifyListeners();
  }

  addToActive(value) {
    for (var item in mNotification) {
      item.notificationListSettings?.forEach((subItem) {
        subItem.isActive = false;
      });
    }
    mNotification[selectedParent].notificationListSettings?.forEach((element) {
      if (value) {
        element.isActive = true;
      } else {
        element.isActive = false;
      }
    });
    notifyListeners();
  }

  changeParentValue(value, NotificationListSettings? item) {
    // mNotification[selectedParent].isActive = value;
    item?.isActive = value;
    notifyListeners();
  }
}
