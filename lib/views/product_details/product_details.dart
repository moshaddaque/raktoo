import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/components/my_app_bar.dart';
import 'package:raktoo/controller/product_controller.dart';
import 'package:raktoo/utils/app_style.dart';
import 'package:raktoo/views/cart/my_cart.dart';

import '../../components/my_button.dart';
import '../../models/products_model.dart';
import '../../utils/colors.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  // final Map<String, dynamic> product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.4,
                    decoration: const BoxDecoration(
                      color: AppColor.catBackground,
                    ),
                    padding: const EdgeInsets.all(30),
                    child: Center(child: Image.network(product.image)),
                  ),

                  //===============================
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName,
                          style: AppStyle.h2Text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "\$${product.productPrice}",
                              style: AppStyle.h3Text,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            product.previousPrice == null
                                ? const SizedBox()
                                : Text(
                                    "\$${product.previousPrice}",
                                    style: AppStyle.h4Text.copyWith(
                                      color:
                                          AppColor.textColor.withOpacity(0.5),
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                            const Spacer(),
                            product.isStockAvailable == true
                                ? const Text(
                                    "Available in stock",
                                    style: AppStyle.h4Text,
                                  )
                                : const Text(
                                    "Stock Out",
                                    style: AppStyle.h4Text,
                                  ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "About",
                          style: AppStyle.h2Text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.description,
                          style: AppStyle.pText.copyWith(
                            fontSize: 18,
                            color: AppColor.textColor.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("products")
                .doc(product.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.data()!["sizes"] == null) {
                return const SizedBox(
                  height: 2,
                );
              } else {
                return SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.data()!["sizes"].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (snapshot.data!.data()!["sizes"].length == null) {
                          return const SizedBox();
                        }
                        return Obx(
                          () => InkWell(
                            onTap: () {
                              controller.selectedIndex.value = index;
                              controller.selectedSize.value = snapshot.data!
                                  .data()!["sizes"][index]
                                  .toString();
                            },
                            child: Container(
                              width: 50,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: controller.selectedIndex.value == index
                                    ? AppColor.primaryColor
                                    : null,
                                border: Border.all(
                                  color: Colors.black.withOpacity(.1),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data!
                                      .data()!['sizes'][index]
                                      .toString(),
                                  style: AppStyle.h3Text.copyWith(
                                    color:
                                        controller.selectedIndex.value == index
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MyButton(
              backgroundColor: AppColor.primaryColor,
              title: "Add to cart",
              titleColor: AppColor.whiteColor,
              onTap: () {
                controller.addToCart(product);
                Get.to(() => const MyCart());
              },
            ),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
        ],
      ),
    );
  }
}
