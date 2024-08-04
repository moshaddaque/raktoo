import 'package:flutter/material.dart';
import 'package:raktoo/utils/app_style.dart';

import '../utils/colors.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String? imageLink;
  final String productPrice;
  final String? sale;
  final String? previousPrice;
  final Function()? onTap;
  final String? tag;

  const ProductCard({
    super.key,
    required this.productName,
    this.imageLink,
    required this.productPrice,
    this.sale,
    this.previousPrice,
    this.onTap,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppColor.catBackground,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppColor.textColor.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: sale == null
                            ? const SizedBox()
                            : Text(
                                "$sale% OFF",
                                style: AppStyle.pText.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.favBorderColor,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          size: 20,
                          color: AppColor.favColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              imageLink == null
                  ? SizedBox(
                      child: Image.asset(
                        "assets/images/no_image_product.png",
                        height: 90,
                        width: 90,
                      ),
                    )
                  : Image.network(
                      imageLink!,
                      height: 90,
                      width: 90,
                    ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  productName.length > 15
                      ? "${productName.substring(0, 15)}.."
                      : productName,
                  style: AppStyle.h4Text.copyWith(
                    color: AppColor.textColor.withOpacity(0.7),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${productPrice}",
                    style: AppStyle.h4Text,
                  ),
                  previousPrice == null
                      ? SizedBox()
                      : Text(
                          "${previousPrice}",
                          style: AppStyle.h4Text.copyWith(
                            fontSize: 18,
                            color: AppColor.textColor.withOpacity(0.5),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
