import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/settings_cubit.dart';
import 'cubit/states.dart';
import '../../config/theme/my_theme.dart';
import 'change_password_screen.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = 'settings-screen';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            size:
                isPortrait ? screenSize.width * 0.07 : screenSize.width * 0.05,
            color: MyTheme.whiteColor,
          ),
        ),
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: isPortrait ? 28 : 30,
              ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => SettingsCubit()..loadSwitchState(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Security",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: isPortrait ? 24 : 26,
                      ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Change Password",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: isPortrait ? 18 : 22,
                          ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, ChangePasswordScreen.routeName),
                        child: Container(
                          width: isPortrait ? 35 : 40,
                          height: isPortrait ? 35 : 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: MyTheme.whiteColor),
                          ),
                          child: const Icon(
                            Icons.lock_outline,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Fingerprint authentication',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: isPortrait ? 18 : 22,
                          ),
                    ),
                    const Spacer(),
                    BlocBuilder<SettingsCubit, SettingsStates>(
                      buildWhen: (previous, current) =>
                          current is BiometricSwitchState,
                      builder: (context, state) {
                        // Show a loading indicator until the biometric state is loaded
                        if (state is SettingsInitialState) {
                          return CupertinoActivityIndicator();
                        }

                        bool isSwitched = false;

                        if (state is BiometricSwitchState) {
                          isSwitched = state.isSwitched;
                        }

                        return CupertinoSwitch(
                          value: isSwitched,
                          onChanged: (value) {
                            context.read<SettingsCubit>().toggleSwitch(value);
                          },
                          trackColor: MyTheme.secondaryColor,
                          activeColor: Colors.blue,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
