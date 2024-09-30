import 'package:flutter/material.dart';
import 'package:sova_vault/config/theme/my_theme.dart';
import 'package:sova_vault/feature/intro/password_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = 'welcome-screen';

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sova Vault',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Image.asset(
              'assets/images/My password-pana.png',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Protect your passwords',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Securely store all your passwords in one place with our vault. For enhanced protection, set up a Master Password or enable biometric unlock. Rest assured, your data stays offline for maximum safety.',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: MyTheme.secondaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.lock_outline),
                ),
              ),
              SizedBox(
                width: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Master Password',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Create a secure password to protect your Sova Vault',
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: MyTheme.secondaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.fingerprint),
                ),
              ),
              SizedBox(
                width: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Biometrics',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Use Touch ID or Face ID to unlock Sova Vault',
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(
                  context, PasswordScreen.routeName),
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
    );
  }
}
