import 'package:flutter/material.dart';
import 'package:raktoo/utils/app_style.dart';
import 'package:raktoo/utils/colors.dart';

class CartTile extends StatelessWidget {
  final String imageLink;
  final String productName;
  final double productPrice;
  final int? productVariant;
  final int? itemCount;
  final void Function() onIncrement;
  final void Function() onDecrement;

  const CartTile({
    super.key,
    required this.imageLink,
    required this.productName,
    required this.productPrice,
    this.productVariant,
    this.itemCount = 1,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        imageLink,
        height: 50,
        width: 50,
      ),
      title: Text(
        productName,
        style: AppStyle.h4Text.copyWith(
          color: AppColor.textColor.withOpacity(.8),
        ),
      ),
      subtitle: Text(
        "\$${productPrice}",
        style: AppStyle.h3Text,
      ),
      trailing: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          productVariant != null
              ? Text(
                  "Size: $productVariant",
                  style: AppStyle.pText.copyWith(fontSize: 15),
                )
              : SizedBox(),
          const Spacer(),
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColor.primaryColor,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onDecrement,
                  icon: const Icon(Icons.remove),
                ),
                SizedBox(
                  width: 10,
                  child: Text("$itemCount"),
                ),
                IconButton(
                  onPressed: onIncrement,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
