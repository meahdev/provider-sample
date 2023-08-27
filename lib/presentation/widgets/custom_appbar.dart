import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar(
      {required this.title,
       this.onLeadingPress,
      this.onSettingPress,
      this.backGroundColor,
      this.isHasSettings = false,
      this.isHasLeading = false,
      this.isCenterTitle = false,
      Key? key})
      : super(key: key);
  final Color? backGroundColor;
  final String title;
  final bool isHasSettings;
  final bool isCenterTitle;
  final bool isHasLeading;
  final Function? onLeadingPress;
  final Function? onSettingPress;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backGroundColor ?? Colors.white,
      title: Text(title,style: const TextStyle(fontSize: 18),),
      leadingWidth: isHasLeading?50:15,
      leading: isHasLeading?IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () {
            onLeadingPress!();
          }):Container(),
      actions: [
        isHasSettings
            ? IconButton(
                onPressed: () {
                  onSettingPress!();
                },
                icon: const Icon(
                  Icons.settings,
                  size: 22,
                ))
            : Container()
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
