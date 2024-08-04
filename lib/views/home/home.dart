import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/components/category_card.dart';
import 'package:raktoo/components/my_app_bar.dart';
import 'package:raktoo/components/my_drawer.dart';
import 'package:raktoo/components/product_card.dart';
import 'package:raktoo/controller/home_controller.dart';
import 'package:raktoo/utils/app_style.dart';
import 'package:raktoo/views/product_details/product_details.dart';
import 'package:raktoo/views/search/search_view.dart';

import '../../components/slider_card.dart';
import '../../utils/colors.dart';
import '../cart/my_cart.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    final controller = Get.put(HomeController());

    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar(
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const SearchView());
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => const MyCart());
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello Fola👋",
                  style: AppStyle.h4Text,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Let’s start shopping!",
                  style: AppStyle.pText.copyWith(
                    color: AppColor.textColor.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () {
                    if (controller.sliders.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return CarouselSlider.builder(
                        itemCount: controller.sliders.length,
                        itemBuilder: (context, index, realIndex) {
                          return SliderCard(
                            imageLink: controller.sliders[index],
                          );
                        },
                        options: CarouselOptions(
                            height: 140,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Top Categories",
                      style: AppStyle.h3Text,
                    ),
                    Text(
                      "See All",
                      style: AppStyle.h3Text.copyWith(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("categories")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return SizedBox(
                        height: 80,
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final category = snapshot.data!.docs[index];
                            return CategoryCard(catImage: category['icon']);
                          },
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.products.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        return ProductCard(
                          productName: product.productName,
                          tag: "img",
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
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
