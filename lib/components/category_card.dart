import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CategoryCard extends StatelessWidget {
  final String catImage;

  const CategoryCard({super.key, required this.catImage});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: AppColor.catBackground,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColor.textColor.withOpacity(0.1),
            width: 2,
          ),
        ),
        child: Image.network(
          catImage,
          height: 60,
          width: 60,
        ));
  }
}
