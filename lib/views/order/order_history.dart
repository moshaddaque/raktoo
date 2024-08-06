import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/components/my_app_bar.dart';
import 'package:raktoo/components/order_list_item.dart';
import 'package:raktoo/controller/order_controller.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final controller = Get.put(OrderController());
    return Scaffold(
      appBar: const MyAppBar(
        title: "Order History",
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.orders.isEmpty) {
            return const Center(
              child: Text("No Orders Found"),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: controller.orders.length,
                itemBuilder: (context, index) {
                  return OrderListItem(
                    order: controller.orders[index],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
