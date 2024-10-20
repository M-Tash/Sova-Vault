import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sova_vault/feature/auth/cubit/auth_cubit.dart';
import 'package:sova_vault/feature/auth/cubit/states.dart';

import '../../config/theme/my_theme.dart';
import '../../core/utils/custom_form_field.dart';
import '../../core/utils/custom_snack_bar.dart';
import '../../core/utils/validators.dart';
import '../home/home_screen.dart';

class LoginPasswordScreen extends StatelessWidget {
  static String routeName = 'login-password-screen';

  LoginPasswordScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          CustomSnackBar.showCustomSnackBar(context, state.message);
        } else if (state is AuthSuccess || state is BiometricAuthSuccess) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: MyTheme.primaryColor,
            body: Column(
              children: [
                Expanded(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Lottie.asset('assets/animations/lock.json',
                                height: isPortrait ? 180 : 150),
                            const SizedBox(height: 30),
                            _buildWelcomeText(context, isPortrait),
                            const SizedBox(height: 40),
                            _buildPasswordForm(
                              context,
                              authCubit,
                              screenSize,
                              isPortrait,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _buildLoginButton(context, authCubit, isPortrait, screenSize),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWelcomeText(BuildContext context, bool isPortrait) {
    return Column(
      children: [
        Text(
          'Welcome Back!',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: isPortrait ? 28 : 30,
                fontWeight: FontWeight.bold,
                color: MyTheme.whiteColor,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'Please enter your password or use biometrics to access your account.',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isPortrait ? 17 : 20,
                color: Colors.grey[300],
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPasswordForm(BuildContext context, AuthCubit authCubit,
      Size screenSize, bool isPortrait) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Password',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: isPortrait ? 18 : 20,
                  color: MyTheme.whiteColor,
                ),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            maxLength: 20,
            validator: Validators.passwordValidator,
            controller: authCubit.passwordController,
            isObscure: authCubit.isObscure,
            suffixIcon: GestureDetector(
              onTap: () => authCubit.toggleObscure(1),
              child: Icon(
                authCubit.isObscure
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
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, AuthCubit authCubit,
      bool isPortrait, Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(
            flex: authCubit.isBiometricEnabled ? 4 : 1,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  authCubit.login();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: MyTheme.secondaryColor,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.black,
                foregroundColor: MyTheme.greyColor,
              ),
              child: Text(
                'Login',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: MyTheme.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: isPortrait ? 18 : 22,
                    ),
              ),
            ),
          ),
          if (authCubit.isBiometricEnabled) ...[
            const SizedBox(width: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: MyTheme.whiteColor, width: 2),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: authCubit.authenticateWithBiometrics,
                icon: Icon(
                  Icons.fingerprint,
                  size: isPortrait
                      ? screenSize.width * 0.09
                      : screenSize.width * 0.06,
                  color: MyTheme.whiteColor,
                ),
                tooltip: 'Login with Biometrics',
              ),
            ),
          ]
        ],
      ),
    );
  }
}
