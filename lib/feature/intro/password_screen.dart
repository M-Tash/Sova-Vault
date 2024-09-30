import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sova_vault/config/utils/custom_form_field.dart';
import 'package:sova_vault/feature/home/home_screen.dart';

import '../../config/theme/my_theme.dart';

class PasswordScreen extends StatefulWidget {
  static String routeName = 'password-screen';

  PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  var formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  bool isObscure = true;
  bool isObscure2 = true;

  // Initialize FlutterSecureStorage instance
  final storage = const FlutterSecureStorage();
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _loadSwitchState(); // Load the switch state when the screen initializes
  }

  // Load the switch state from SharedPreferences
  Future<void> _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = prefs.getBool('biometric_enabled') ?? false;
    });
  }

  // Save the switch state to SharedPreferences
  Future<void> _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('biometric_enabled', value);
  }

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
    _saveSwitchState(value); // Save the new state when the switch is toggled
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size and orientation
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'One last thing..',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: isPortrait ? 26 : 30, // Adjust title size dynamically
              ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            // Expanding content to fill available space
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenSize.height * 0.025),
                  Text(
                    'Set up your Password',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: isPortrait ? 22 : 26, // Adjust font size
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenSize.height * 0.025),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.01),
                    child: Text(
                      "You should set a strong and secure master password that you'll remember.",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: isPortrait ? 17 : 20, // Adjust font size
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.01),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Create Password',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize:
                                      isPortrait ? 18 : 22, // Adjust font size
                                ),
                          ),
                          const SizedBox(height: 5),
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
                                  : Icon(Icons.visibility_outlined,
                                      size: 20, color: MyTheme.whiteColor),
                              onTap: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                            ),
                            isSuffixIcon: true,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: screenSize.height * 0.025),
                          Text(
                            'Confirm Password',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize:
                                      isPortrait ? 18 : 22, // Adjust font size
                                ),
                          ),
                          const SizedBox(height: 5),
                          CustomTextFormField(
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please Confirm Your Password';
                              }
                              if (confirmPasswordController.text !=
                                  passwordController.text) {
                                return "Password doesn't match";
                              }
                              return null;
                            },
                            controller: confirmPasswordController,
                            isObscure: isObscure2,
                            suffixIcon: GestureDetector(
                              child: isObscure2
                                  ? Icon(Icons.visibility_off_outlined,
                                      size: 20, color: MyTheme.whiteColor)
                                  : Icon(Icons.visibility_outlined,
                                      size: 20, color: MyTheme.whiteColor),
                              onTap: () {
                                setState(() {
                                  isObscure2 = !isObscure2;
                                });
                              },
                            ),
                            isSuffixIcon: true,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          Row(
                            children: [
                              Text(
                                'Biometrics',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: isPortrait
                                          ? 18
                                          : 22, // Adjust font size
                                    ),
                              ),
                              const Spacer(),
                              CupertinoSwitch(
                                value: isSwitched,
                                onChanged: toggleSwitch,
                                trackColor: MyTheme.secondaryColor,
                                activeColor: Colors.blue,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: GestureDetector(
              onTap: () async {
                if (formKey.currentState?.validate() ?? false) {
                  // Save the password securely
                  await storage.write(
                      key: 'user_password', value: passwordController.text);

                  // Ensure the widget is still mounted before navigating
                  if (mounted) {
                    // Navigate to the HomeScreen
                    Navigator.pushReplacementNamed(
                        context, HomeScreen.routeName);
                  }
                }
              },
              child: Container(
                height: isPortrait
                    ? screenSize.height * 0.06
                    : screenSize.height * 0.15,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: MyTheme.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: isPortrait ? 18 : 22, // Adjust font size
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
