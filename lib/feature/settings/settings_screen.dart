import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/theme/my_theme.dart';
import 'change_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = 'settings-screen';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _loadSwitchState(); // Load the switch state when the screen initializes
  }

  // Load the switch state from SharedPreferences
  Future<void> _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = prefs.getBool('biometric_enabled') ?? false;
    });
  }

  // Save the switch state to SharedPreferences
  Future<void> _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('biometric_enabled', value);
  }

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
    _saveSwitchState(value); // Save the new state when the switch is toggled
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: isPortrait
                  ? screenSize.width * 0.07
                  : screenSize.width * 0.05, // Adjust the size dynamically
              color: MyTheme.whiteColor,
            )),
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: isPortrait ? 28 : 30, // Adjust font size dynamically
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                screenSize.width * 0.03, // Adjust padding based on screen width
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                "Security",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize:
                          isPortrait ? 24 : 26, // Adjust font size dynamically
                    ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Change Password",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: isPortrait
                              ? 18
                              : 22, // Adjust font size dynamically
                        ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, ChangePasswordScreen.routeName),
                      child: Container(
                          width: isPortrait ? 35 : 40, // Adjust container size
                          height: isPortrait ? 35 : 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: MyTheme.whiteColor)),
                          child: const Icon(
                            Icons.lock_outline,
                            size: 28,
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Biometrics',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: isPortrait
                              ? 18
                              : 22, // Adjust font size dynamically
                        ),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    value: isSwitched,
                    onChanged: toggleSwitch,
                    trackColor: MyTheme.secondaryColor,
                    activeColor: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
