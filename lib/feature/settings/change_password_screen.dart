import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sova_vault/config/utils/custom_snack_bar.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_form_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  static String routeName = 'change-password-screen';

  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool isObscure = true;
  bool isObscure2 = true;

  // Initialize FlutterSecureStorage instance
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: isPortrait
                  ? screenSize.width * 0.07
                  : screenSize.width * 0.05, // Adjust the size dynamically
              color: MyTheme.whiteColor,
            )),
        centerTitle: true,
        title: Text(
          'Master Password',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize:
                    isPortrait ? 28 : 30, // Adjust font size for orientation
              ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            // Wrap main content in Expanded to keep it flexible
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05), // Responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Change Your Master Password',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: isPortrait ? 20 : 24, // Adjust font size
                        ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "You should set a secure master password that you'll remember.",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: isPortrait ? 17 : 20, // Adjust font size
                        ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Password',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize:
                                  isPortrait ? 18 : 24, // Adjust font size
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Your password must be 6 numbers.",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize:
                                  isPortrait ? 16 : 20, // Adjust font size
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Form(
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
                                    isPortrait ? 18 : 24, // Adjust font size
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
                          keyboardType: TextInputType.number,
                          // Ensure numeric keyboard for password
                          maxLength: 6,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Confirm Password',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontSize:
                                    isPortrait ? 18 : 24, // Adjust font size
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
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 140),
                  // Adjust spacing based on screen size
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: GestureDetector(
              onTap: () async {
                if (formKey.currentState?.validate() ?? false) {
                  // Save the new password securely
                  await storage.write(
                      key: 'user_password', value: passwordController.text);

                  if (mounted) {
                    // Show a success message
                    CustomSnackBar.showCustomSnackBar(
                        context, 'Password has been changed successfully!');

                    // Optionally, navigate back or to another screen
                    Navigator.pop(context);
                  }
                }
              },
              child: Container(
                height: isPortrait
                    ? screenSize.height * 0.06
                    : screenSize.height * 0.15,
                width: double.infinity, // Full width
                decoration: BoxDecoration(
                    color: MyTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    'Change Password',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: isPortrait ? 18 : 24, // Adjust font size
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
