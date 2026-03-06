class AppStrings {
  AppStrings._();

  // ==================== Error Messages ====================
  static const String signupFailed = 'Signup failed';
  static const String networkError = 'Network error. Please try again.';
  static const String connectionTimeout =
      'Connection timeout. Please try again.';
  static const String noInternet =
      'No internet connection. Please check your network.';
  static const String somethingWentWrong =
      'Something went wrong. Please try again.';
  static const String signupSuccess = 'Signup successful! Please login.';

  // ==================== Validation Messages ====================

  // Username
  static const String usernameRequired = 'Username is required';
  static const String usernameInvalid =
      'Username must be 3-20 characters, and contain only letters, numbers, or underscores';

  // Email
  static const String emailRequired = 'Email is required';
  static const String emailInvalid = 'This Email is not valid';

  // Password
  static const String passwordRequired = 'Password is required';
  static const String passwordInvalid =
      'Password must be at least 8 characters with uppercase, lowercase, and numbers';

  // Confirm Password
  static const String confirmPasswordRequired = 'Confirm your password';
  static const String passwordsDoNotMatch = 'Passwords do not match';

  // Phone
  static const String phoneRequired = 'Phone number is required';
  static const String phoneInvalid = 'Please enter a valid phone number';

  // First/Last Name
  static const String firstNameRequired = 'First name is required';
  static const String lastNameRequired = 'Last name is required';

  // ==================== Button Labels ====================
  static const String signup = 'Signup';
  static const String signingUp = 'Signing up...';
  static const String login = 'Login';
  static const String submit = 'Submit';
  static const String cancel = 'Cancel';

  // ==================== Navigation ====================
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String dontHaveAccount = "Don't have an account?";
}
