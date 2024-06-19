class AppValidator {
  static String? Function(String? value) emailValidator = (String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    String pattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  };

  static String? Function(String? value) passwordValidator = (String? value) {
    const String passwordPattern =
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\S+$).{8,32}$';
    final RegExp regex = RegExp(passwordPattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your Password';
    } else if (!regex.hasMatch(value ?? '')) {
      return 'Password must contain at least one digit, one lowercase letter, one uppercase letter, one special character, and be between 8 to 32 characters long.';
    }
  };
  static String? Function(String? value) generalValidator = (String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
  };
}
