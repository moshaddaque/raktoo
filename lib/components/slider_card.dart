import 'package:flutter/material.dart';

class SliderCard extends StatelessWidget {
  final String imageLink;

  const SliderCard({super.key, required this.imageLink});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageLink),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
