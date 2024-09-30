import 'package:flutter/material.dart';
import 'package:sova_vault/config/theme/my_theme.dart';

class CustomSnackBar {
  static void showCustomSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: MyTheme.secondaryColor,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
