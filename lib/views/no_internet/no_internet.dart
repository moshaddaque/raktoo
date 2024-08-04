import 'package:flutter/material.dart';
import 'package:raktoo/components/my_app_bar.dart';

import '../../utils/colors.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: const MyAppBar(title: 'No Internet Connection'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                'No internet connection available.\n Please check your connection.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              Image.asset("assets/images/no_internet.jpg"),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
