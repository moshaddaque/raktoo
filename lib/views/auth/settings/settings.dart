import 'package:flutter/material.dart';
import 'package:raktoo/components/my_app_bar.dart';
import 'package:raktoo/components/my_text_field.dart';
import 'package:raktoo/components/settings_tile.dart';
import 'package:raktoo/utils/app_style.dart';

import '../../../components/my_button.dart';
import '../../../utils/colors.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
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
                      builder: (context) {
                        return SizedBox(
                          width: double.infinity,
                          height: 800,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SingleChildScrollView(
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
                                    hintText: "Full Name",
                                    onChanged: (p0) {},
                                    isObsecure: false,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MyTextField(
                                    hintText: "Address",
                                    onChanged: (value) {
                                      // controller.address.value = value;
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
                                      // controller.phoneNumber.value = value;
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
                                    isLoading: false,
                                    titleColor: AppColor.whiteColor,
                                    onTap: () {
                                      // if (controller.setupFormKey.currentState!
                                      //     .validate()) {
                                      //   controller.profileSetUp();
                                      // }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
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
