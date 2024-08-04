import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/components/my_app_bar.dart';
import 'package:raktoo/components/my_button.dart';
import 'package:raktoo/components/my_text_field.dart';
import 'package:raktoo/controller/auth_controller.dart';
import 'package:raktoo/utils/app_style.dart';
import 'package:raktoo/utils/colors.dart';
import 'package:raktoo/views/auth/register/register.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controller = Get.put(AuthController());

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Login here",
                        style: AppStyle.h2Text.copyWith(
                          color: AppColor.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome back you’ve been missed!",
                        style: AppStyle.pText.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: formKey,
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
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot your password?",
                            style: AppStyle.pText.copyWith(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MyButton(
                          backgroundColor: AppColor.primaryColor,
                          title: "Sign In",
                          titleColor: AppColor.whiteColor,
                          isLoading: controller.isLoading.value,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              controller.signIn();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyButton(
                          backgroundColor: AppColor.transparentColor,
                          title: "Create new account",
                          titleColor: AppColor.textColor,
                          onTap: () {
                            Get.to(() => const Register());
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
