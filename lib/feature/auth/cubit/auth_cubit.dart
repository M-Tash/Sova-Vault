import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sova_vault/feature/auth/cubit/states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final storage = const FlutterSecureStorage();
  final LocalAuthentication auth = LocalAuthentication();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isObscure = true;
  bool isObscure2 = true;
  bool isSwitched = false;
  bool isBiometricEnabled = false;

  void toggleObscure(int fieldIndex) {
    if (fieldIndex == 1) {
      isObscure = !isObscure;
    } else if (fieldIndex == 2) {
      isObscure2 = !isObscure2;
    }
    emit(AuthVisibilityToggled());
  }

  Future<void> loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isSwitched = prefs.getBool('biometric_enabled') ?? false;
    isBiometricEnabled = isSwitched;
    emit(SwitchStateUpdated());
  }

  Future<void> toggleSwitch(bool value) async {
    isSwitched = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometric_enabled', value);
    isBiometricEnabled = value;
    emit(SwitchStateUpdated());
  }

  Future<void> register() async {
    if (passwordController.text.length < 6) {
      emit(AuthError('Password must be at least 6 characters long'));
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      emit(AuthError("Passwords don't match"));
      return;
    }

    emit(AuthLoading());
    try {
      await storage.write(key: 'user_password', value: passwordController.text);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Failed to save password'));
    }
  }

  Future<void> login() async {
    emit(AuthLoading());
    try {
      String? storedPassword = await storage.read(key: 'user_password');
      if (storedPassword == passwordController.text) {
        emit(AuthSuccess());
      } else {
        emit(AuthError('Incorrect password'));
      }
    } catch (e) {
      emit(AuthError('Failed to login'));
    }
  }

  Future<void> authenticateWithBiometrics() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate to access your account',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (authenticated) {
        emit(BiometricAuthSuccess());
      } else {
        emit(BiometricAuthFailed());
      }
    } catch (e) {
      emit(AuthError('Biometric authentication failed'));
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}