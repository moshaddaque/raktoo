import 'package:flutter/material.dart';
import 'package:raktoo/utils/app_style.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style:
                      AppStyle.h4Text.copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }
}
