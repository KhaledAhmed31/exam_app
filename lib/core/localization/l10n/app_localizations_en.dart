// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get forgetPasswordScreenTitle => 'Password';

  @override
  String get forgetPasswordTitle => 'Forget password';

  @override
  String get forgetPasswordDescription =>
      'Please enter your email associated to your account';

  @override
  String get verifyCodeTitle => 'Verification Code';

  @override
  String get verifyCodeDescription =>
      'Please enter your code that send to your email address';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get doNotReceiveCode => 'Do not receive the code?';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get resetPasswordDescription =>
      'Password must not be empty and must contain 6 characters with upper case letter and one number at least';

  @override
  String get continueButton => 'Continue';

  @override
  String get resendCodeSuccessMessage => 'Code sent successfully';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get confirmPasswordHint => 'Confirm password';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'New password';

  @override
  String get confirmPassowrdLabel => 'Confirm password';

  @override
  String get loginTitle => 'Login';

  @override
  String get rememberMeTitle => 'Remember Me';

  @override
  String get doNotHaveAccount => 'Don\'t have an account? ';

  @override
  String get signUpTitle => 'sign Up';

  @override
  String get exploreTabLabel => 'Explore';

  @override
  String get resultTabLabel => 'Result';

  @override
  String get profileTabLabel => 'Profile';

  @override
  String get successTitle => 'Success';

  @override
  String get errorTitle => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get loadingTitle => 'Loading...';
}
