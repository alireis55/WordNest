String? emailValidator(String? value) {
  if (value!.isEmpty) {
    return 'Email is required';
  }
  if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

class PasswordValidator {
  static int? validate6Charecter(String? value) {
    if (value!.length >= 6) {
      return null;
    } else {
      return 1;
    }
  }

  static int? validateSpecialCharecter(String? value) {
    if (RegExp(r'[!@#<>?.": _`~;[\]\\|=+)(*&^%-]').hasMatch(value.toString())) {
      return null;
    }
    return 1;
  }

  static int? validateUpperCase(String? value) {
    if (RegExp(r'[A-Z]').hasMatch(value.toString())) {
      return null;
    }
    return 1;
  }

  static int? validateLowerCase(String? value) {
    if (RegExp(r'[a-z]').hasMatch(value.toString())) {
      return null;
    }
    return 1;
  }

  static int? validateNumber(String? value) {
    if (RegExp(r'[0-9]').hasMatch(value.toString())) {
      return null;
    }
    return 1;
  }
}
