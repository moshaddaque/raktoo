import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/components/my_app_bar.dart';
import 'package:raktoo/controller/order_controller.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final controller = Get.put(OrderController());
    return Scaffold(
      appBar: MyAppBar(
        title: "Order History",
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: controller.orderList.length,
                  itemBuilder: (context, index) {
                    final product = controller.orderList[index];

                    // for (int item = 0;
                    //     item <= product['items'].length;
                    //     item++) {
                    //
                    // }
                    return ListTile(
                      title:
                          Text(product['items'][0]['product_name'].toString()),
                      subtitle: Text(product['time'].toString()),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
