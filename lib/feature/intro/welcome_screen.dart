import 'package:flutter/material.dart';
import 'package:sova_vault/config/theme/my_theme.dart';

import '../auth/password_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = 'welcome-screen';

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size and orientation
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sova Vault',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize:
                    isPortrait ? 28 : 30, // Adjust font size for orientation
              ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              // Add scrolling behavior for the content
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width *
                      0.04, // Adjust padding based on screen width
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: isPortrait
                          ? screenSize.height * 0.3
                          : screenSize.height * 0.4, // Adjust height
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/My password-pana.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.015),
                    Text(
                      'Protect your passwords',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: isPortrait ? 22 : 26, // Adjust font size
                          ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.04),
                      // Adjust padding
                      child: Text(
                        'Securely store all your passwords in one place with our vault. For enhanced protection, set up a Master Password or enable biometric unlock. Rest assured, your data stays offline for maximum safety.',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  isPortrait ? 17 : 20, // Adjust font size
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.025),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            height: isPortrait ? 50 : 55,
                            width: isPortrait ? 50 : 55,
                            decoration: BoxDecoration(
                              color: MyTheme.secondaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.lock_outline),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Master Password',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      fontSize: isPortrait
                                          ? 18
                                          : 22, // Adjust font size
                                    ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Create a secure password to protect your Sova Vault',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      fontSize: isPortrait
                                          ? 15
                                          : 18, // Adjust font size
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            height: isPortrait ? 50 : 55,
                            width: isPortrait ? 50 : 55,
                            decoration: BoxDecoration(
                              color: MyTheme.secondaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.fingerprint),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Biometrics',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      fontSize: isPortrait
                                          ? 18
                                          : 22, // Adjust font size
                                    ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Use Touch ID or Face ID to unlock Sova Vault',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      fontSize: isPortrait
                                          ? 15
                                          : 18, // Adjust font size
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.04),
                    // Adjusted spacing to account for scroll
                  ],
                ),
              ),
            ),
          ),
          // Continue button always at the bottom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(
                  context, PasswordScreen.routeName),
              child: Container(
                height: isPortrait
                    ? screenSize.height * 0.06
                    : screenSize.height * 0.15,
                width: double.infinity, // Make button fill available width
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
                          color: MyTheme.whiteColor,
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
