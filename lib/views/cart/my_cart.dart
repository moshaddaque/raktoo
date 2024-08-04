import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/components/my_app_bar.dart';
import 'package:raktoo/components/my_button.dart';
import 'package:raktoo/controller/cart_controller.dart';
import 'package:raktoo/utils/colors.dart';
import 'package:raktoo/views/payment/payment_view.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final controller = Get.put(CartController());
    return Scaffold(
      appBar: MyAppBar(
        title: "My Cart",
        actions: [
          IconButton(
            onPressed: () async {
              final cart = await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user!.email)
                  .collection('cart')
                  .get();

              for (var item in cart.docs) {
                await item.reference.delete();
              }
              Get.snackbar("Cart Delete", "Cart deleted successfully");
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: controller.cart.length,
                          itemBuilder: (_, index) {
                            final product = controller.cart[index];

                            return ListTile(
                              leading: Image.network(product['product_image']),
                              title: Text(
                                product['product_name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text('\$${product['price']}'),
                              trailing: Column(
                                children: [
                                  product['variant'] == null
                                      ? const SizedBox()
                                      : Text('Size: ${product['variant']}'),
                                  Container(
                                    height: 40,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColor.primaryColor,
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.descrease(product.id);
                                          },
                                          child: const Icon(
                                            Icons.remove,
                                          ),
                                        ),
                                        Text(
                                          product['quantity'].toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.increase(product.id);
                                          },
                                          child: const Icon(
                                            Icons.add,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Obx(
                          () => Text(
                            '\$${controller.totalPrice.value}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MyButton(
                backgroundColor: AppColor.primaryColor,
                title: "Buy Now",
                titleColor: AppColor.whiteColor,
                onTap: () {
                  final cartItem = controller.cart;

                  List<Map<String, dynamic>> cartData = cartItem
                      .map((cart) => cart.data() as Map<String, dynamic>)
                      .toList();

                  Get.to(
                    () => PaymentView(
                      cartData: cartData,
                      totalAmount: controller.totalPrice.value,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
