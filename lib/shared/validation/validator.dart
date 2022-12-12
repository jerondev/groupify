/// Validate user input and data
class Validator {
  /// Validates Full Name and needs to be more than 4 characters
  static String? name(String? value) {
    const pattern = r'(^[a-zA-Z ]*$)';
    final regExp = RegExp(pattern);
    if (regExp.hasMatch(value!) && value.trim().length > 4) {
      return null;
    } else if (value.trim().length < 5) {
      return 'Full name must be more than 4 characters';
    }
    return null;
  }

  /// Pattern checks for valid phone Numbers
  static String? phoneNumber(String? value) {
    if (value!.isEmpty) {
      return '😉 Come on, don\'t be shy, enter your number';
    } else if (value.length == 9) {
      return "🏃 Come on, last digit";
    } else if (value.length < 10) {
      return '👏 Come on, ${10 - value.length} digits more';
    }

    /// When [value] is greater than 10
    else if (value.length > 10) {
      return '📢 Valid phone numbers are 10 digits right ?';
    }
    return null;
  }

  /// pattern for a valid code must start in either grp or comm

  static String? validCode(String? value) {
    if (value!.isEmpty) {
      return "Come on, enter the code";
    } else if (!value.startsWith("grp") && !value.startsWith("comm")) {
      return "Invalid community or group code";
    } else if (value.startsWith('grp') && value.length != 13) {
      return "Invalid group code";
    } else if (value.startsWith('comm') && value.length != 14) {
      return "Invalid Community code";
    }

    return null;
  }
}
