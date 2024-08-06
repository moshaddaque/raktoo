import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktoo/components/my_app_bar.dart';
import 'package:raktoo/components/my_text_field.dart';
import 'package:raktoo/components/settings_tile.dart';
import 'package:raktoo/controller/auth_controller.dart';
import 'package:raktoo/utils/app_style.dart';

import '../../../components/my_button.dart';
import '../../../utils/colors.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: const MyAppBar(
        title: "Settings",
      ),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                SettingsTile(
                  icon: Icons.person,
                  title: "Edit Profile",
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return SizedBox(
                          width: double.infinity,
                          height: 800,
                          child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Obx(
                                () {
                                  if (controller.user.value.email.isEmpty) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return SingleChildScrollView(
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Update Your Profile",
                                              style: AppStyle.h4Text,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            MyTextField(
                                              initialText: controller
                                                  .user.value.fullName,
                                              hintText: "Full Name",
                                              onChanged: (value) {
                                                controller.user.value.fullName =
                                                    value;
                                              },
                                              isObsecure: false,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            MyTextField(
                                              initialText:
                                                  controller.user.value.address,
                                              hintText: "Address",
                                              onChanged: (value) {
                                                controller.user.value.address =
                                                    value;
                                              },
                                              isObsecure: false,
                                              isRequired: true,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            MyTextField(
                                              initialText: controller
                                                  .user.value.phoneNumber,
                                              hintText: "Phone Number",
                                              onChanged: (value) {
                                                controller.user.value
                                                    .phoneNumber = value;
                                              },
                                              isObsecure: false,
                                              isRequired: true,
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            MyButton(
                                              backgroundColor:
                                                  AppColor.primaryColor,
                                              title: "Update Profile",
                                              isLoading:
                                                  controller.isLoading.value,
                                              titleColor: AppColor.whiteColor,
                                              onTap: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  controller
                                                      .updateProfileData();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              )),
                        );
                      },
                    );
                  },
                ),
                SettingsTile(
                  icon: Icons.lock_open_rounded,
                  title: "Reset Password",
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
