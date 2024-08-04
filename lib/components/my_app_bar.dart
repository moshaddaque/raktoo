import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:raktoo/utils/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;

  const MyAppBar({super.key, this.leading, this.actions, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.transparentColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: title == null ? const SizedBox() : Text(title!),
      leading: leading ??
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
