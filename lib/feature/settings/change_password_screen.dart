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
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: MyTheme.whiteColor,
            )),
        centerTitle: true,
        title: Text(
          'Master Password',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Change Your Master Password',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                "You should set a secure master password that you'll remember.",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Your password must be 6 numbers.",
                    style: Theme.of(context).textTheme.labelSmall,
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
                      style: Theme.of(context).textTheme.bodyMedium,
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
                                size: 18, color: MyTheme.whiteColor)
                            : Icon(Icons.visibility_outlined,
                                size: 18, color: MyTheme.whiteColor),
                        onTap: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                      isSuffixIcon: true,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Confirm Password',
                      style: Theme.of(context).textTheme.bodyMedium,
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
                                size: 18, color: MyTheme.whiteColor)
                            : Icon(Icons.visibility_outlined,
                                size: 18, color: MyTheme.whiteColor),
                        onTap: () {
                          setState(() {
                            isObscure2 = !isObscure2;
                          });
                        },
                      ),
                      isSuffixIcon: true,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 140),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                    height: 48,
                    width: 358,
                    decoration: BoxDecoration(
                        color: MyTheme.secondaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        'Change Password',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
