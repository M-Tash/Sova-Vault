import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'states.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Form-related variables in the cubit
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isObscure = true;
  bool isObscure2 = true;

  SettingsCubit() : super(SettingsInitialState());

  // Load the initial state of the biometric switch
  Future<void> loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitched = prefs.getBool('biometric_enabled') ?? false;
    emit(BiometricSwitchState(isSwitched: isSwitched));
  }

  // Toggle the switch state and save it
  Future<void> toggleSwitch(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometric_enabled', value);
    emit(BiometricSwitchState(isSwitched: value));
  }

  // Toggle the visibility of the password field
  void togglePasswordVisibility() {
    isObscure = !isObscure;
    emit(PasswordVisibilityState(isObscure: isObscure, isObscure2: isObscure2));
  }

  // Toggle the visibility of the confirm password field
  void toggleConfirmPasswordVisibility() {
    isObscure2 = !isObscure2;
    emit(PasswordVisibilityState(isObscure: isObscure, isObscure2: isObscure2));
  }

  // Validate form inputs
  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      if (passwordController.text != confirmPasswordController.text) {
        emit(FormValidationErrorState("Passwords do not match"));
        return false;
      }
      return true;
    } else {
      emit(FormValidationErrorState("Please fill out all fields"));
      return false;
    }
  }

  // Save the password securely
  Future<void> changePassword() async {
    if (validateForm()) {
      try {
        await _storage.write(
            key: 'user_password', value: passwordController.text);
        emit(PasswordChangedState());
      } catch (e) {
        emit(FormValidationErrorState(
            "An error occurred while saving the password"));
      }
    }
  }

  // Dispose of controllers when done
  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
