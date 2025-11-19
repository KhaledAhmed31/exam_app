// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get forgetPasswordScreenTitle => 'كلمة المرور';

  @override
  String get forgetPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get forgetPasswordDescription =>
      'الرجاء إدخال بريدك الإلكتروني المرتبط بحسابك';

  @override
  String get verifyCodeTitle => 'رمز التحقق';

  @override
  String get verifyCodeDescription =>
      'الرجاء إدخال الرمز المرسل إلى بريدك الإلكتروني';

  @override
  String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get doNotReceiveCode => 'لم تتلقَ الرمز؟';

  @override
  String get resendCode => 'إعادة إرسال الرمز';

  @override
  String get resetPasswordDescription =>
      'يجب ألا تكون كلمة المرور فارغة ويجب أن تحتوي على 6 أحرف على الأقل وحرف كبير ورقم واحد على الأقل';

  @override
  String get continueButton => 'متابعة';

  @override
  String get resendCodeSuccessMessage => 'تم إرسال الرمز بنجاح';

  @override
  String get emailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get confirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور الجديدة';

  @override
  String get confirmPassowrdLabel => 'تأكيد كلمة المرور';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get rememberMeTitle => 'تذكرني';

  @override
  String get doNotHaveAccount => 'ليس لديك حساب؟ ';

  @override
  String get signUpTitle => 'انشاء حساب';

  @override
  String get exploreTabLabel => 'استكشفاف';

  @override
  String get resultTabLabel => 'النتيجة';

  @override
  String get profileTabLabel => 'الحساب الشخصي';

  @override
  String get successTitle => 'تم بنجاح';

  @override
  String get errorTitle => 'خطأ';

  @override
  String get ok => 'تم';

  @override
  String get loadingTitle => 'تحميل';
}
