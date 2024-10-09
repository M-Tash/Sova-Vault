import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sova_vault/config/theme/my_theme.dart';
import 'package:sova_vault/feature/content_pages/gaming_screen.dart';
import 'package:sova_vault/feature/content_pages/social_media_screen.dart';
import 'package:sova_vault/feature/data_screen/accounts_screen.dart';
import 'package:sova_vault/feature/home/home_screen.dart';
import 'package:sova_vault/feature/intro/splash_screen.dart'; // Import the SplashScreen
import 'package:sova_vault/feature/intro/welcome_screen.dart';
import 'package:sova_vault/feature/settings/change_password_screen.dart';
import 'package:sova_vault/feature/settings/settings_screen.dart';

import 'feature/auth/login_password_screen.dart'; // Import the login screen
import 'feature/auth/password_screen.dart';
import 'feature/content_pages/email_screen.dart';
import 'feature/content_pages/shopping_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Create an instance of FlutterSecureStorage
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Set SplashScreen as the initial route
      initialRoute: SplashScreen.routeName,
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
        SplashScreen.routeName: (context) => SplashScreen(),
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        PasswordScreen.routeName: (context) => PasswordScreen(),
        // BiometricScreen.routeName: (context) => const BiometricScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
        ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
        SocialScreen.routeName: (context) => SocialScreen(),
        GamingScreen.routeName: (context) => GamingScreen(),
        EmailScreen.routeName: (context) => EmailScreen(),
        ShoppingScreen.routeName: (context) => ShoppingScreen(),
        LoginPasswordScreen.routeName: (context) =>
            LoginPasswordScreen(isBiometricEnabled: false),
        // Default false, to be updated from SplashScreen
      },
      theme: MyTheme.darkMode,
    );
  }
}
