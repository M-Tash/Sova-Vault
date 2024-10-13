abstract class SettingsStates {}

// Initial state for loading the switch state.
class SettingsInitialState extends SettingsStates {}

// State to indicate whether the biometric switch is ON or OFF.
class BiometricSwitchState extends SettingsStates {
  final bool isSwitched;

  BiometricSwitchState({required this.isSwitched});
}

// State for managing the visibility of the password fields.
class PasswordVisibilityState extends SettingsStates {
  final bool isObscure;
  final bool isObscure2;

  PasswordVisibilityState({required this.isObscure, required this.isObscure2});
}

// State for form validation errors.
class FormValidationErrorState extends SettingsStates {
  final String errorMessage;

  FormValidationErrorState(this.errorMessage);
}

// State for successful password change.
class PasswordChangedState extends SettingsStates {}
