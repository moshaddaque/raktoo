import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:raktoo/components/my_button.dart';
import 'package:raktoo/utils/app_style.dart';
import 'package:raktoo/utils/colors.dart';
import 'package:raktoo/views/auth/login/login.dart';
import 'package:raktoo/views/auth/register/register.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 30,
          ),
          child: Column(
            children: [
              Image.asset("assets/images/welcome_banner.png"),
              const Spacer(),
              Text(
                "Discover Your Dream Job here",
                style: AppStyle.h2Text.copyWith(
                  color: AppColor.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Explore all the existing job roles based on your interest and study major",
                style: AppStyle.pText,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      backgroundColor: AppColor.primaryColor,
                      title: "Login",
                      titleColor: AppColor.whiteColor,
                      onTap: () {
                        Get.to(() => const Login());
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: MyButton(
                      backgroundColor: AppColor.transparentColor,
                      title: "Register",
                      titleColor: AppColor.textColor,
                      onTap: () {
                        Get.to(() => const Register());
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
