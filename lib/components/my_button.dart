import 'package:flutter/material.dart';
import 'package:raktoo/utils/app_style.dart';
import 'package:raktoo/utils/colors.dart';

class MyButton extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final Color titleColor;
  final void Function()? onTap;
  final bool? isLoading;

  const MyButton({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.titleColor,
    required this.onTap,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoading == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: AppColor.whiteColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Loading...",
                      style: AppStyle.h4Text.copyWith(
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ],
                )
              : Text(
                  title,
                  style: AppStyle.h4Text.copyWith(
                    color: titleColor,
                  ),
                ),
        ),
      ),
    );
  }
}
