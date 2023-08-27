

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_provider_test/application/provider/dashboard/dashboard_provider.dart';
import 'package:flutter_provider_test/application/provider/notification/notification_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/strings.dart';
import '../../domain/notification/notification_settings.dart';
import '../widgets/custom_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildCustomAppbar(context),
        body: _bodyView(context),
    );
  }

  CustomAppbar buildCustomAppbar(BuildContext context) {
    return CustomAppbar(
      title: AppStrings.settingTitle,
      isHasLeading: true,
      onLeadingPress: () {
        Navigator.pop(context);
      },
      backGroundColor: AppColors.lightGrey,
    );
  }

  _bodyView(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NotificationProvider>().getNotificationList();
    });
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Consumer<NotificationProvider>(
          builder: (context,provider, child){
            return  Column(
              children: [
                buildParentList(provider),
               provider.isHasItems? buildSubList(provider):Container(),

              ],
            );
          },
        ),
      ),
    );
  }

  Card buildSubList(NotificationProvider notificationProvider) {
    return Card(
        elevation: 1.0,
        color: AppColors.cardColor,
        child: buildSubListColumnItem(notificationProvider));
  }

  Card buildParentList(NotificationProvider notificationProvider) {
    return Card(
      elevation: 1.0,
      color: AppColors.cardColor,
      child:
      buildParentColumnItem(notificationProvider),
    );
  }

   buildParentColumnItem(NotificationProvider notificationProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildText(
              title: AppStrings.notificationSettings,
              fontColor: AppColors.headerColor,
              fontWeight: FontWeight.w500,
              fontSize: 17.5),
          buildSizedBox(height: 10),
          ListView.builder(
              padding: const EdgeInsets.only(bottom: 25),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: notificationProvider.mNotification.length,
              itemBuilder: (context, index) {
                var item =  notificationProvider.mNotification[index];
                return
                    buildRow(item, index, AppColors.listSubTitleColor, 15,notificationProvider);
              }),
        ],
      ),
    );
  }

   buildSubListColumnItem(NotificationProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildText(
              title: AppStrings.notificationSettings,
              fontColor: AppColors.headerColor,
              fontWeight: FontWeight.w500,
              fontSize: 17.5),
          buildSizedBox(height: 10),
            ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 5),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              // itemCount: controller.itemLength.value,
              itemCount: 1,
              itemBuilder: (context, index) {
                var parentItem = provider
                    .mNotification[provider.selectedParent];
                return Column(
                  children: [
                    // left: 0,
                    // right: 25,
                   Padding(padding: const EdgeInsets.only(
                     left: 0, right: 25,
                   ),
                     child:  buildRow(parentItem, index, AppColors.listHeaderColor, 16,provider),
                   ),
                ListView.builder(
                        padding: const EdgeInsets.only(top: 8, bottom: 5),
                        physics: const ClampingScrollPhysics(),
                        itemCount: provider
                            .mNotification[
                        provider.selectedParent]
                            .notificationListSettings
                            ?.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i2) {
                          print('ex- $i2}');
                          NotificationListSettings? subItem = parentItem.notificationListSettings?[i2];
                          return buildRowSublist(subItem,provider);
                        }),
                  ],
                );
              }),
        ],
      ),
    );
  }

   buildRow(
      NotificationSettings item, int index, Color color, double fontSize,NotificationProvider notificationProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildText(
              title: item.title,
              fontSize: fontSize,
              fontColor: color,
              fontWeight: FontWeight.w500),
          buildAnimatedToggleSwitchParent(item, index,notificationProvider),
        ],
      ),
    );
  }

  AnimatedToggleSwitch<bool> buildAnimatedToggleSwitchSubList(
      NotificationListSettings ?item, NotificationProvider provider) {
    return AnimatedToggleSwitch<bool>.dual(
      borderRadius: BorderRadius.circular(6),
      innerColor: AppColors.switchBackGround,
      current: item?.isActive ?? false,
      first: false,
      second: true,
      dif: 0.0,
      borderColor: Colors.transparent,
      borderWidth: 1.0,
      height: 30,
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 1.5),
        ),
      ],
      onChanged: (value) {
       provider.changeParentValue(value,item);
      },
      colorBuilder: (v) => Colors.transparent,
      iconBuilder: (value) => value
          ? buildNeumorphicIcon(
        icon: Icons.ac_unit_outlined,
      )
          : buildNeumorphicIcon(
        icon: Icons.ac_unit_outlined,
      ),
      textBuilder: (value) => value
          ? Center(
          child: _buildText(
              title: AppStrings.on,
              fontColor: AppColors.switchON,
              fontWeight: FontWeight.bold))
          : Center(
          child: _buildText(
              title: AppStrings.off,
              fontColor: AppColors.switchOff,
              fontWeight: FontWeight.bold)),
    );
  }

  AnimatedToggleSwitch<bool> buildAnimatedToggleSwitchParent(
      NotificationSettings item, int index, NotificationProvider provider) {
    return AnimatedToggleSwitch<bool>.dual(
      borderRadius: BorderRadius.circular(6),
      innerColor: AppColors.switchBackGround,
      current: item.isActive ?? false,
      first: false,
      second: true,
      dif: 0.0,
      borderColor: Colors.transparent,
      borderWidth: 1.0,
      height: 30,
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 1.5),
        ),
      ],
      onChanged: (value) {
        if (value &&
            item.notificationListSettings != null &&
            item.notificationListSettings!.isNotEmpty) {
          provider.itemsIn(true);
        } else {
          provider.itemsIn(false);

        }
        provider.clearValues();
        item.isActive = value;
        provider.selectedParent = index;
        provider.addToActive(value);

        // print('Length == ${item.notificationListSettings?.length} and ${controller.selectedParent.value}');
      },
      colorBuilder: (v) => Colors.transparent,
      iconBuilder: (value) => value
          ? buildNeumorphicIcon(
        icon: Icons.ac_unit_outlined,
      )
          : buildNeumorphicIcon(
        icon: Icons.ac_unit_outlined,
      ),
      textBuilder: (value) => value
          ? Center(
          child: _buildText(
              title: AppStrings.on,
              fontColor: AppColors.switchON,
              fontWeight: FontWeight.bold))
          : Center(
          child: _buildText(
              title: AppStrings.off,
              fontColor: AppColors.switchOff,
              fontWeight: FontWeight.bold)),
    );
  }

  NeumorphicIcon buildNeumorphicIcon({required IconData icon}) {
    return NeumorphicIcon(
      icon,
      style:  NeumorphicStyle(
        color: Colors.white,
        shape: NeumorphicShape.flat,
        boxShape:
        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      ),
      size: 27,
    );
  }

  buildRowSublist(NotificationListSettings? item,NotificationProvider provider) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildText(
              title: item?.title??"",
              fontSize: 15,
              fontColor: AppColors.listSubTitleColor,
              fontWeight: FontWeight.w500),
          buildAnimatedToggleSwitchSubList(item,provider),
        ],
      ),
    );
  }

  Text _buildText(
      {required title,
        double? fontSize,
        Color? fontColor,
        FontWeight? fontWeight}) {
    return Text(
      title,
      style: GoogleFonts.roboto(
          color: fontColor, fontSize: fontSize, fontWeight: fontWeight),
    );
  }

  SizedBox buildSizedBox({double? height, double? width}) {
    return SizedBox(
      height: height ?? 0.0,
      width: width ?? 0.0,
    );
  }
}
