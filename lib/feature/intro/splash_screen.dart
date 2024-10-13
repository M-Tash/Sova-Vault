import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sova_vault/config/theme/my_theme.dart';
import 'package:sova_vault/feature/intro/welcome_screen.dart';
import 'package:sova_vault/feature/auth/login_password_screen.dart';
import '../auth/cubit/auth_cubit.dart';
import 'cubit/splash_cubit.dart';
import 'cubit/states.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = 'splash-screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..checkEverything(),
      child: Scaffold(
        backgroundColor: MyTheme.primaryColor,
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashNavigateToLogin) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPasswordScreen(),
                ),
              );
            } else if (state is SplashNavigateToWelcome) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WelcomeScreen(),
                ),
              );
            }
          },
          child: Center(
            child: FadeInDownBig(
              duration: const Duration(milliseconds: 2200),
              child: Image.asset('assets/images/SOVA.png'),
            ),
          ),
        ),
      ),
    );
  }
}