abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigateToLogin extends SplashState {
  final bool isBiometricEnabled;

  SplashNavigateToLogin({required this.isBiometricEnabled});
}

class SplashNavigateToWelcome extends SplashState {}
