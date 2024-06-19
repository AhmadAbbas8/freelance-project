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
    if (value == null || value.isEmpty) {
      return 'Please enter your Password';
    }
  };
}
