import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sova_vault/config/theme/my_theme.dart';
import 'package:sova_vault/feature/intro/welcome_screen.dart';

import 'login_password_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = 'splash-screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = const FlutterSecureStorage();
  bool isBiometricEnabled = false;

  @override
  void initState() {
    super.initState();

    // Start the splash screen process after 2 seconds delay
    Future.delayed(const Duration(seconds: 3), () {
      _checkEverything(); // Start checking password and biometric settings
    });
  }

  Future<String?> _checkPassword() async {
    // Check if a password is stored
    String? password = await storage.read(key: 'user_password');
    return password;
  }

  Future<bool> _checkBiometricsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isBiometricEnabled = prefs.getBool('biometric_enabled') ?? false;
    return isBiometricEnabled;
  }

  Future<void> _checkEverything() async {
    await _checkPassword();
    await _checkBiometricsEnabled();

    // Once all checks are complete, navigate based on the password state
    _navigateBasedOnPassword();
  }

  void _navigateBasedOnPassword() async {
    String? password = await _checkPassword();

    // Ensure the widget is still mounted before performing navigation
    if (!mounted) return;

    if (password != null) {
      // Navigate to LoginPasswordScreen if a password exists
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LoginPasswordScreen(isBiometricEnabled: isBiometricEnabled),
        ),
      );
    } else {
      // Navigate to WelcomeScreen if no password exists
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.primaryColor,
      // Set the background color of the splash screen
      body: Center(
        child: FadeInDownBig(
          duration: const Duration(seconds: 2),
          // Control the animation duration
          child: Image.asset(
            'assets/images/SOVA.png', // Use your custom image
          ),
        ),
      ),
    );
  }
}
