import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'One last thing..',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              'Set up your Password',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Text(
                "You should set a strong and secure master password that you'll remember.",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Your password must be 6 numbers.",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Create Password',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
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
                            : Icon(
                                Icons.visibility_outlined,
                                size: 18,
                                color: MyTheme.whiteColor,
                              ),
                        onTap: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                      isSuffixIcon: true,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Confirm Password',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
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
                            : Icon(
                                Icons.visibility_outlined,
                                size: 18,
                                color: MyTheme.whiteColor,
                              ),
                        onTap: () {
                          setState(() {
                            isObscure2 = !isObscure2;
                          });
                        },
                      ),
                      isSuffixIcon: true,
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 140, bottom: 30),
              child: GestureDetector(
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    // Handle valid PIN input
                    Navigator.pushReplacementNamed(
                        context, HomeScreen.routeName);
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
                      'Continue',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
