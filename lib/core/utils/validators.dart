class Validators {
  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please Enter Your Password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? accPasswordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please Enter Your Password';
    }
    return null;
  }

  static String? accEmailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please Enter Your Email';
    }
    return null;
  }

  static String? confirmPasswordValidator(String? value, String? confirmValue) {
    if (value == null || value.trim().isEmpty) {
      return 'Please Confirm Your Password';
    }
    if (value != confirmValue) {
      return "Password doesn't match";
    }
    return null;
  }

  static String? titleValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please Enter title';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please Enter Your Email';
    }
    return null;
  }
}
