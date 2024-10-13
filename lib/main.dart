import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sova_vault/config/theme/my_theme.dart';
import 'package:sova_vault/feature/content_pages/gaming_screen.dart';
import 'package:sova_vault/feature/content_pages/social_media_screen.dart';
import 'package:sova_vault/feature/data_screen/service_screen.dart';
import 'package:sova_vault/feature/home/home_screen.dart';
import 'package:sova_vault/feature/intro/splash_screen.dart';
import 'package:sova_vault/feature/intro/welcome_screen.dart';
import 'package:sova_vault/feature/settings/change_password_screen.dart';
import 'package:sova_vault/feature/settings/settings_screen.dart';

import 'feature/auth/login_password_screen.dart';
import 'feature/auth/password_screen.dart';
import 'feature/content_pages/email_screen.dart';
import 'feature/content_pages/shopping_screen.dart';
import 'feature/auth/cubit/auth_cubit.dart';
import 'feature/auth/cubit/states.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..loadSwitchState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: (settings) {
          if (settings.name == ServiceScreen.routeName) {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) =>
                  ServiceScreen(serviceName: args['serviceName']),
            );
          }
          if (settings.name == LoginPasswordScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) => BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return LoginPasswordScreen();
                },
              ),
            );
          }
          assert(false, 'Need to implement ${settings.name}');
          return null;
        },
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          WelcomeScreen.routeName: (context) => const WelcomeScreen(),
          PasswordScreen.routeName: (context) => const PasswordScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          SettingsScreen.routeName: (context) => const SettingsScreen(),
          ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
          SocialScreen.routeName: (context) => SocialScreen(),
          GamingScreen.routeName: (context) => GamingScreen(),
          EmailScreen.routeName: (context) => EmailScreen(),
          ShoppingScreen.routeName: (context) => ShoppingScreen(),
          // LoginPasswordScreen is now handled in onGenerateRoute
        },
        theme: MyTheme.darkMode,
      ),
    );
  }
}