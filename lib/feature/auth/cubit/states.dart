abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class BiometricAuthSuccess extends AuthState {}

class BiometricAuthFailed extends AuthState {}

class AuthVisibilityToggled extends AuthState {}

class SwitchStateUpdated extends AuthState {}
