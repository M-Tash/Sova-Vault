import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sova_vault/feature/auth/cubit/auth_cubit.dart';
import 'package:sova_vault/feature/auth/cubit/states.dart';

import '../../config/theme/my_theme.dart';
import '../../core/utils/custom_form_field.dart';
import '../../core/utils/validators.dart';
import '../home/home_screen.dart';

class PasswordScreen extends StatelessWidget {
  static String routeName = 'password-screen';
  final _formKey = GlobalKey<FormState>();

  PasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'One last thing..',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: isPortrait ? 26 : 30,
                    ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: screenSize.height * 0.025),
                        Text(
                          'Set up your Password',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: isPortrait ? 22 : 26,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenSize.height * 0.025),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.01),
                          child: Text(
                            "You should set a strong and secure master password that you'll remember.",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontSize: isPortrait ? 17 : 20,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.01),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                  "Your password must be at least 6 numbers.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        fontSize: isPortrait ? 16 : 20,
                                      ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Create Password',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontSize: isPortrait ? 18 : 22,
                                      ),
                                ),
                                const SizedBox(height: 5),
                                CustomTextFormField(
                                  maxLength: 20,
                                  validator: Validators.passwordValidator,
                                  controller: cubit.passwordController,
                                  isObscure: cubit.isObscure,
                                  suffixIcon: GestureDetector(
                                    onTap: () => cubit.toggleObscure(1),
                                    child: Icon(
                                      cubit.isObscure
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      size: isPortrait
                                          ? screenSize.width * 0.06
                                          : screenSize.width * 0.04,
                                      color: MyTheme.whiteColor,
                                    ),
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
                                        fontSize: isPortrait ? 18 : 22,
                                      ),
                                ),
                                const SizedBox(height: 5),
                                CustomTextFormField(
                                  maxLength: 20,
                                  validator: (value) =>
                                      Validators.confirmPasswordValidator(
                                          value, cubit.passwordController.text),
                                  controller: cubit.confirmPasswordController,
                                  isObscure: cubit.isObscure2,
                                  suffixIcon: GestureDetector(
                                    onTap: () => cubit.toggleObscure(2),
                                    child: Icon(
                                      cubit.isObscure2
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      size: isPortrait
                                          ? screenSize.width * 0.06
                                          : screenSize.width * 0.04,
                                      color: MyTheme.whiteColor,
                                    ),
                                  ),
                                  isSuffixIcon: true,
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(height: screenSize.height * 0.02),
                                Row(
                                  children: [
                                    Text(
                                      'Fingerprint authentication',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontSize: isPortrait ? 18 : 22,
                                          ),
                                    ),
                                    const Spacer(),
                                    CupertinoSwitch(
                                      value: cubit.isSwitched,
                                      onChanged: cubit.toggleSwitch,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        cubit.register();
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
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: isPortrait ? 18 : 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
