import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/components/my_app_bar.dart';
import 'package:raktoo/components/my_button.dart';
import 'package:raktoo/components/my_text_field.dart';
import 'package:raktoo/controller/auth_controller.dart';
import 'package:raktoo/utils/app_style.dart';
import 'package:raktoo/utils/colors.dart';

class ProfileSetUp extends StatelessWidget {
  const ProfileSetUp({super.key});

  @override
  Widget build(BuildContext context) {
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
                children: [
                  Text(
                    "Profile Setup",
                    style: AppStyle.h2Text.copyWith(
                      color: AppColor.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Please fill be below details to complete your profile.",
                    style: AppStyle.pText,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.primaryColor,
                            width: 2,
                          ),
                          image: controller.selectedImage.value.path == ''
                              ? const DecorationImage(
                                  image: NetworkImage(
                                    "https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: FileImage(
                                    controller.selectedImage.value,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor.primaryColor,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: AppColor.primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: controller.setupFormKey,
                    child: Column(
                      children: [
                        MyTextField(
                          hintText: "Full Name",
                          onChanged: (value) {
                            controller.fullName.value = value;
                          },
                          isObsecure: false,
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          hintText: "Address",
                          onChanged: (value) {
                            controller.address.value = value;
                          },
                          isObsecure: false,
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          hintText: "Phone Number",
                          onChanged: (value) {
                            controller.phoneNumber.value = value;
                          },
                          isObsecure: false,
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MyButton(
                          backgroundColor: AppColor.primaryColor,
                          title: "Complete Setup",
                          isLoading: controller.isLoading.value,
                          titleColor: AppColor.whiteColor,
                          onTap: () {
                            if (controller.isLoading.value == true) {}
                            if (controller.setupFormKey.currentState!
                                .validate()) {
                              controller.profileSetUp();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
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
