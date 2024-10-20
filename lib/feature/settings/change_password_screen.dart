import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme/my_theme.dart';
import '../../core/utils/custom_form_field.dart';
import '../../core/utils/custom_snack_bar.dart';
import '../../core/utils/validators.dart';
import 'cubit/settings_cubit.dart';
import 'cubit/states.dart';

class ChangePasswordScreen extends StatelessWidget {
  static String routeName = 'change-password-screen';

  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Dismiss keyboard when tapping outside
        },
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                size: isPortrait
                    ? screenSize.width * 0.07
                    : screenSize.width * 0.05,
                color: MyTheme.whiteColor,
              ),
            ),
            centerTitle: true,
            title: Text(
              'Master Password',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: isPortrait ? 28 : 30,
                  ),
            ),
          ),
          body: BlocConsumer<SettingsCubit, SettingsStates>(
            listener: (context, state) {
              if (state is PasswordChangedState) {
                CustomSnackBar.showCustomSnackBar(
                  context,
                  'Password has been changed successfully!',
                );
                Navigator.pop(
                    context); // Navigate back after successful password change
              } else if (state is FormValidationErrorState) {
                CustomSnackBar.showCustomSnackBar(context, state.errorMessage);
              }
            },
            builder: (context, state) {
              var cubit = context.read<SettingsCubit>();

              bool isObscure = cubit.isObscure;
              bool isObscure2 = cubit.isObscure2;

              if (state is PasswordVisibilityState) {
                isObscure = state.isObscure;
                isObscure2 = state.isObscure2;
              }

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Change Your Master Password',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: isPortrait ? 20 : 24,
                                ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "You should set a secure master password that you'll remember.",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontSize: isPortrait ? 17 : 20,
                                ),
                          ),
                          const SizedBox(height: 30),
                          Form(
                            key: cubit.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomTextFormField(
                                  maxLength: 20,
                                  validator: Validators.passwordValidator,
                                  controller: cubit.passwordController,
                                  isObscure: isObscure,
                                  suffixIcon: GestureDetector(
                                    child: isObscure
                                        ? Icon(Icons.visibility_off_outlined,
                                            size: isPortrait
                                                ? screenSize.width * 0.06
                                                : screenSize.width * 0.04,
                                            color: MyTheme.whiteColor)
                                        : Icon(Icons.visibility_outlined,
                                            size: isPortrait
                                                ? screenSize.width * 0.06
                                                : screenSize.width * 0.04,
                                            color: MyTheme.whiteColor),
                                    onTap: () {
                                      cubit.togglePasswordVisibility();
                                    },
                                  ),
                                  isSuffixIcon: true,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 10),
                                CustomTextFormField(
                                  maxLength: 20,
                                  validator: (value) =>
                                      Validators.confirmPasswordValidator(
                                          value, cubit.passwordController.text),
                                  controller: cubit.confirmPasswordController,
                                  isObscure: isObscure2,
                                  suffixIcon: GestureDetector(
                                    child: isObscure2
                                        ? Icon(Icons.visibility_off_outlined,
                                            size: isPortrait
                                                ? screenSize.width * 0.06
                                                : screenSize.width * 0.04,
                                            color: MyTheme.whiteColor)
                                        : Icon(Icons.visibility_outlined,
                                            size: isPortrait
                                                ? screenSize.width * 0.06
                                                : screenSize.width * 0.04,
                                            color: MyTheme.whiteColor),
                                    onTap: () {
                                      cubit.toggleConfirmPasswordVisibility();
                                    },
                                  ),
                                  isSuffixIcon: true,
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 140),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        cubit.changePassword();
                      },
                      child: Container(
                        height: isPortrait
                            ? screenSize.height * 0.06
                            : screenSize.height * 0.15,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: MyTheme.secondaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            'Change Password',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: isPortrait ? 18 : 24,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
