import 'package:flutter/material.dart';
import 'package:raktoo/utils/colors.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final void Function(String)? onChanged;
  final bool isObsecure;
  final bool? isRequired;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.isObsecure,
    this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: isRequired == true
          ? (String? value) {
              if (value == null || value.isEmpty) {
                return "This Field is Required";
              }
              return null;
            }
          : null,
      onChanged: onChanged,
      obscureText: isObsecure,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColor.filledBackground,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColor.primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
