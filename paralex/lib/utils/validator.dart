class Validators {
  static final emailPattern = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
    r"[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}"
    r"[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}"
    r"[a-zA-Z0-9])?)+$",
  );

  static String? minLength(String? value, int minLength) {
    if ((value?.length ?? 0) < minLength) {
      return "Minimum of $minLength characters.";
    }
    return null;
  }

  static Validator pinLength(int minLength) {
    return (String? value) {
      if ((value?.length ?? 0) < minLength) {
        return "Minimum of $minLength characters.";
      }
      return null;
    };
  }

  static bool isValid(String pin, String pin2) =>
      (pin.isNotEmpty && pin2.isNotEmpty && pin == pin2);

  static Validator matchPattern(Pattern pattern, [String? patternName]) {
    return (String? value) {
      if (value == null || (pattern.allMatches(value).isEmpty)) {
        return "Please enter a valid ${patternName ?? "value"}.";
      }
      return null;
    };
  }

  static Validator email() {
    return matchPattern(emailPattern, "email");
  }
}

typedef Validator = String? Function(String value);
