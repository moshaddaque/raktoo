import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/controller/search_controller.dart';

import '../product_details/product_details.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchesController());
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search products...',
          ),
          onChanged: (value) {
            controller.searchProducts(value);
          },
        ),
      ),
      body: Obx(
        () {
          if (controller.searchResults.isEmpty) {
            return const Center(child: Text('No products found.'));
          } else {
            return ListView.builder(
              itemCount: controller.searchResults.length,
              itemBuilder: (context, index) {
                var product = controller.searchResults[index];
                return ListTile(
                  title: Text(product.productName),
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
