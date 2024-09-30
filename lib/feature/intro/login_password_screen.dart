import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:sova_vault/config/utils/custom_form_field.dart';
import 'package:sova_vault/feature/home/home_screen.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_snack_bar.dart';

class LoginPasswordScreen extends StatefulWidget {
  static String routeName = 'login-password-screen';

  final bool isBiometricEnabled;

  LoginPasswordScreen({required this.isBiometricEnabled});

  @override
  State<LoginPasswordScreen> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  var formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  bool isObscure = true;

  // Initialize FlutterSecureStorage instance
  final storage = const FlutterSecureStorage();

  // Initialize LocalAuthentication instance for biometric auth
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Authenticate to access your account',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print(e);
    }
    return authenticated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Lottie.asset('assets/animations/lock.json', height: 180),
                const SizedBox(height: 30),
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.whiteColor,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Please enter your password or use biometrics to access your account.',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 14,
                        color: Colors.grey[300],
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Password',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: MyTheme.whiteColor,
                            ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        isObscure: isObscure,
                        suffixIcon: GestureDetector(
                          child: isObscure
                              ? Icon(Icons.visibility_off_outlined,
                                  size: 20, color: MyTheme.whiteColor)
                              : Icon(
                                  Icons.visibility_outlined,
                                  size: 20,
                                  color: MyTheme.whiteColor,
                                ),
                          onTap: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                        isSuffixIcon: true,
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 150),
                Row(
                  children: [
                    // Login Button
                    Expanded(
                      flex: widget.isBiometricEnabled ? 4 : 1,
                      // Full width if biometrics are disabled
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            String? storedPassword =
                                await storage.read(key: 'user_password');

                            if (mounted) {
                              if (storedPassword == passwordController.text) {
                                Navigator.pushReplacementNamed(
                                    context, HomeScreen.routeName);
                              } else {
                                CustomSnackBar.showCustomSnackBar(
                                    context, 'Incorrect password.');
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: MyTheme.secondaryColor,
                          // Normal background color
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadowColor: Colors.black,
                          foregroundColor: MyTheme.greyColor,
                        ),
                        child: Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: MyTheme.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                    if (widget.isBiometricEnabled) ...[
                      const SizedBox(width: 20), // Space between buttons
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: MyTheme.whiteColor, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () async {
                            bool isBiometricSupported =
                                await auth.canCheckBiometrics;

                            if (isBiometricSupported) {
                              bool authenticated =
                                  await authenticateWithBiometrics();

                              if (mounted) {
                                if (authenticated) {
                                  Navigator.pushReplacementNamed(
                                      context, HomeScreen.routeName);
                                } else {
                                  CustomSnackBar.showCustomSnackBar(context,
                                      'Biometric authentication failed.');
                                }
                              }
                            } else {
                              if (mounted) {
                                CustomSnackBar.showCustomSnackBar(context,
                                    'Biometric authentication is not available on this device.');
                              }
                            }
                          },
                          icon: Icon(
                            Icons.fingerprint,
                            size: 30,
                            color: MyTheme.whiteColor,
                          ),
                          tooltip: 'Login with Biometrics',
                        ),
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
