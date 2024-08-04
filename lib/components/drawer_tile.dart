import 'package:flutter/material.dart';
import 'package:raktoo/utils/app_style.dart';

class DrawerTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Function()? onTap;

  const DrawerTile({super.key, this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        title,
        style: AppStyle.pText,
      ),
    );
  }
}
