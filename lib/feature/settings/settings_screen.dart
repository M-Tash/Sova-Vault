import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/theme/my_theme.dart';
import '../../config/utils/custom_Item.dart';
import '../../config/utils/custom_bottom_navigation_bar.dart';
import 'change_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = 'settings-screen';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
      // Call your function here when the switch is turned on
      onSwitchTurnedOn();
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  void onSwitchTurnedOn() {
    // Your function code here
    print("Switch is turned ON");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: MyTheme.whiteColor,
            )),
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Security",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Master Password",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, ChangePasswordScreen.routeName),
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: MyTheme.whiteColor)),
                          child: const Icon(
                            Icons.lock_outline,
                            size: 20,
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Biometrics',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    value: isSwitched,
                    onChanged: toggleSwitch,
                    trackColor: MyTheme.secondaryColor,
                    activeColor: Colors.blue,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
