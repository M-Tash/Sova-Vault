import 'package:flutter/material.dart';
import 'package:sova_vault/config/theme/my_theme.dart';
import 'package:sova_vault/feature/content_pages/gaming_screen.dart';
import 'package:sova_vault/feature/content_pages/social_media_screen.dart';
import 'package:sova_vault/feature/data_screen/accounts_screen.dart';
import 'package:sova_vault/feature/home/home_screen.dart';
import 'package:sova_vault/feature/intro/biometric_screen.dart';
import 'package:sova_vault/feature/intro/password_screen.dart';
import 'package:sova_vault/feature/intro/welcome_screen.dart';
import 'package:sova_vault/feature/settings/change_password_screen.dart';
import 'package:sova_vault/feature/settings/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: (settings) {
        if (settings.name == ServiceScreen.routeName) {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return ServiceScreen(serviceName: args['serviceName']);
            },
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
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
