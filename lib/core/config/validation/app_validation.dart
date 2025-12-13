import 'package:exam_app/core/constants/app_strings.dart';

class Validators {
  static bool notEmpty(String? text) => text != null && text.trim().isNotEmpty;

  static String? nameValidator(String? val) {
    RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]{2,50}$');
    if (val == null || val.isEmpty) {
      return "Enter your name";
    } else if (!nameRegExp.hasMatch(val)) {
      return "Enter valid name";
    } else {
      return null;
    }
  }

  static String? usernameValidator(String? val) {
    RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

    if (val == null || val.isEmpty) {
      return AppStrings.usernameRequired;
    } else if (!usernameRegExp.hasMatch(val)) {
      return AppStrings.usernameInvalid;
    } else {
      return null;
    }
  }

  static String? phoneValidator(String? val) {
    RegExp phoneRegExp = RegExp(r'^\d{10,15}$');
    if (val == null || val.isEmpty) {
      return AppStrings.phoneRequired;
    } else if (!phoneRegExp.hasMatch(val)) {
      return AppStrings.phoneInvalid;
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? val) {
    if (val == null || val.isEmpty) {
      return AppStrings.passwordRequired;
    } else if (val.length < 8) {
      return "Password must be at least 8 characters long";
    } else if (!val.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    } else if (!val.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter";
    } else if (!val.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one numeric character";
    } else if (!val.contains(RegExp(r'[!@#\$%^&*()<>?/|}{~:]'))) {
      return "Password must contain at least one special character";
    }
    return null;
  }

  static String? confirmPasswordValidator(
    String? val,
    String? confirmPassword,
  ) {
    if (val == null || val.isEmpty) {
      return AppStrings.confirmPasswordRequired;
    } else if (val != confirmPassword) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }

  static String? signInPasswordValidator(String? val) {
    if (val == null || val.isEmpty) {
      return AppStrings.passwordRequired;
    }
    return null;
  }

  static String? emailValidator(String? val) {
    RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (val == null || val.isEmpty) {
      return AppStrings.emailRequired;
    } else if (!emailRegExp.hasMatch(val)) {
      return AppStrings.emailInvalid;
    } else {
      return null;
    }
  }
}
