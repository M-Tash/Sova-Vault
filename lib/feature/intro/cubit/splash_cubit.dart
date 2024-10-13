import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sova_vault/feature/intro/cubit/states.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  final storage = const FlutterSecureStorage();

  Future<void> checkEverything() async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 3));

    final password = await _checkPassword();
    final isBiometricEnabled = await _checkBiometricsEnabled();

    if (password != null) {
      emit(SplashNavigateToLogin(isBiometricEnabled: isBiometricEnabled));
    } else {
      emit(SplashNavigateToWelcome());
    }
  }

  Future<String?> _checkPassword() async {
    return await storage.read(key: 'user_password');
  }

  Future<bool> _checkBiometricsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('biometric_enabled') ?? false;
  }
}
