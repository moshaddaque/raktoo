import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/components/my_app_bar.dart';
import 'package:raktoo/components/product_card.dart';
import 'package:raktoo/controller/product_controller.dart';

import '../product_details/product_details.dart';

class Products extends StatefulWidget {
  final String catId;

  const Products({super.key, required this.catId});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final controller = Get.put(ProductController());
  bool noProductsFound = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getProductsByCategory(widget.catId);
    Timer(
      const Duration(seconds: 3),
      () {
        if (controller.products.isEmpty) {
          noProductsFound = true;
        }
      },
    );
    // Future.delayed(
    //   const Duration(seconds: 5),
    //   () {
    //     if (controller.products.isEmpty) {
    //       noProductsFound = true;
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Products",
      ),
      body: Obx(
        () {
          if (controller.products.isEmpty) {
            if (noProductsFound) {
              return const Center(child: Text("No products"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          } else {
            return GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: controller.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final product = controller.products[index];
                return ProductCard(
                  productName: product.productName,
                  imageLink: product.image,
                  productPrice: product.productPrice,
                  previousPrice: product.previousPrice,
                  sale: product.sale,
                  onTap: () {
                    Get.to(() => ProductDetails(product: product));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
