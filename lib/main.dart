import 'package:flutter/material.dart';
import 'package:sova_vault/feature/content_pages/gaming_screen.dart';
import 'package:sova_vault/feature/content_pages/social_media_screen.dart';
import 'package:sova_vault/feature/home/home_screen.dart';
import 'package:sova_vault/feature/intro/biometric_screen.dart';
import 'package:sova_vault/feature/settings/change_password_screen.dart';

import 'config/theme/my_theme.dart';
import 'feature/intro/password_screen.dart';
import 'feature/intro/welcome_screen.dart';
import 'feature/settings/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        PasswordScreen.routeName: (context) => PasswordScreen(),
        BiometricScreen.routeName: (context) => const BiometricScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
        ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
        SocialScreen.routeName: (context) => SocialScreen(),
        GamingScreen.routeName: (context) => GamingScreen(),
      },
      theme: MyTheme.darkMode,
    );
  }
}
