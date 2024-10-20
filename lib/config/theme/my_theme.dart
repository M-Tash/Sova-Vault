import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = const Color(0xff121721);
  static Color lightPrimaryColor = const Color(0xff1A2133);
  static Color secondaryColor = const Color(0xff243047);
  static Color logoColor = const Color(0xFFE1E1E1);
  static Color lightGreyColor = const Color(0xff94A6C7);
  static Color greyColor = const Color(0xff94B0C7);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color redColor = const Color(0xffFF5252);

  static ThemeData darkMode = ThemeData(
      scaffoldBackgroundColor: primaryColor,
      colorScheme: ColorScheme.dark(primary: primaryColor),
      primaryColor: primaryColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: lightGreyColor,
          backgroundColor: Colors.transparent,
          elevation: 0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          shape: const StadiumBorder(
              side: BorderSide(color: Colors.white, width: 3, strokeAlign: 2))),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
        titleMedium: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),
        titleSmall: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, color: whiteColor),
        displayLarge: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, color: whiteColor),
        displayMedium: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w300, color: redColor),
        displaySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: lightGreyColor,
        ),
        bodyMedium: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: whiteColor),
        labelSmall: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: lightGreyColor),
        labelLarge: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: whiteColor),
        bodySmall: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w300, color: whiteColor),
        bodyLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor),
      ));
}
