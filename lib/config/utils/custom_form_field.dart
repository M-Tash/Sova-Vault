import 'package:flutter/material.dart';
import 'package:sova_vault/config/theme/my_theme.dart';

class CustomTextFormField extends StatelessWidget {
  Widget? suffixIcon;
  bool isObscure;
  bool? isSuffixIcon;
  TextInputType keyboardType;
  String? Function(String?)? validator;
  TextEditingController? controller;
  double width;
  double height;
  int maxLength;

  CustomTextFormField({
    super.key,
    this.suffixIcon,
    this.isSuffixIcon,
    this.isObscure = false,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.width = 358,
    this.height = 50,
    this.maxLength = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 80,
        child: SizedBox(
          height: 40,
          child: TextFormField(
            cursorColor: Colors.white,
            maxLength: maxLength,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              counterText: "",
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16),
              ),
              filled: true,
              fillColor: MyTheme.lightPrimaryColor,
              contentPadding:
                  const EdgeInsets.only(bottom: 10, top: 20, left: 20),
            ),
            style: Theme.of(context).textTheme.titleMedium,
            validator: validator,
            controller: controller,
            obscureText: isObscure,
            keyboardType: keyboardType,
          ),
        ),
      ),
    );
  }
}
