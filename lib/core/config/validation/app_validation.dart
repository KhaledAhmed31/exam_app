class Validators {
  static bool notEmpty(String? text) => text != null && text.trim().isNotEmpty;

  static String? nameValidator(String? val) {
    RegExp nameRegExp = RegExp('[a-zA-Z]');
    if (val == null || val.isEmpty) {
      return "Enter your name";
    } else if (!nameRegExp.hasMatch(val)) {
      return "Enter valid name";
    } else {
      return null;
    }
  }

  static String? phoneValidator(String? val) {
    RegExp phoneRegExp = RegExp(r'\d');
    if (val == null || val.isEmpty) {
      return "Enter your number";
    } else if (!phoneRegExp.hasMatch(val)) {
      return "Enter valid number";
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? val) {
    if (val == null || val.isEmpty) {
      return "Password is required";
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
  static String? confirmPasswordValidator(String? val, String? confirmPassowrd) {
    if (val == null || val.isEmpty) {
      return "Password is required";
    }else if(val != confirmPassowrd){
      return "Password doesn't match";
    }
    return null;
  }

  static String? signInPasswordValidator(String? val) {
    if (val == null || val.isEmpty) {
      return "Password is required";
    }

    return null;
  }

  static String? emailValidator(String? val) {
    RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (val == null || val.isEmpty) {
      return "Enter your email";
    } else if (!emailRegExp.hasMatch(val)) {
      return "Enter valid email";
    } else {
      return null;
    }
  }
}
