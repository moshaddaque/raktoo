import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/components/my_app_bar.dart';
import 'package:raktoo/components/my_button.dart';
import 'package:raktoo/components/my_text_field.dart';
import 'package:raktoo/utils/app_style.dart';
import 'package:raktoo/utils/colors.dart';
import 'package:raktoo/views/auth/login/login.dart';

import '../../../controller/auth_controller.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    // final formKey = GlobalKey<FormState>();
    // final auth = FirebaseAuth.instance;
    final controller = Get.put(AuthController());
    // TextEditingController emailController = TextEditingController();
    // TextEditingController passwordController = TextEditingController();
    // TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        "Create Account",
                        style: AppStyle.h2Text.copyWith(
                          color: AppColor.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Create an account so you can explore all the existing jobs",
                        style: AppStyle.pText,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        MyTextField(
                          hintText: "Email",
                          onChanged: (value) {
                            controller.email.value = value;
                          },
                          isObsecure: false,
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          hintText: "Password",
                          onChanged: (value) {
                            controller.password.value = value;
                          },
                          isObsecure: true,
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          hintText: "Confirm Password",
                          onChanged: (value) {
                            controller.cPassword.value = value;
                          },
                          isObsecure: true,
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Obx(
                          () => MyButton(
                            backgroundColor: AppColor.primaryColor,
                            title: "Sign up",
                            titleColor: AppColor.whiteColor,
                            isLoading: controller.isLoading.value,
                            onTap: () {
                              controller.signUp();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyButton(
                          backgroundColor: AppColor.transparentColor,
                          title: "Already have an account",
                          titleColor: AppColor.textColor,
                          onTap: () {
                            Get.to(() => const Login());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
