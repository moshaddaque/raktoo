import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/components/drawer_tile.dart';
import 'package:raktoo/views/auth/privacy/privacy_policy.dart';
import 'package:raktoo/views/auth/settings/settings.dart';
import 'package:raktoo/views/order/order_history.dart';

import '../controller/auth_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue[300]?.withOpacity(0.5),
              radius: 60,
              child: const CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/raktoo_logo.jpg",
                ), //NetworkImage
                radius: 50,
              ), //CircleAvatar
            ),
          ),
          const Divider(),
          DrawerTile(
            title: "H O M E",
            icon: Icons.home_filled,
            onTap: () {
              Get.back();
            },
          ),
          DrawerTile(
            title: "O R D E R S",
            icon: Icons.shopping_basket,
            onTap: () {
              Get.to(() => const OrderHistory());
            },
          ),
          DrawerTile(
            title: "S E T T I N G",
            icon: Icons.settings,
            onTap: () {
              Get.to(() => const Settings());
            },
          ),
          DrawerTile(
            title: "P R I V E C Y P O L I C Y",
            icon: Icons.settings,
            onTap: () {
              Get.to(() => const PrivacyPolicy());
            },
          ),
          const Spacer(),
          DrawerTile(
            title: "L O G O U T",
            icon: Icons.logout,
            onTap: () {
              controller.signOut();
            },
          ),
        ],
      ),
    );
  }
}
