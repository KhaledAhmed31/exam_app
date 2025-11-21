class ApiConsts {
  // Base URL (the const part of the URL)
  static const String baseUrl = "https://exam.elevateegy.com/api/v1";

  // Auth EndPoints
  static const String loginEndPoint = "/auth/signin";
  static const String registerEndPoint = "/auth/signup";
  static const String logoutEndPoint = "/auth/logout";
  static const String forgetPasswordEndPoint = "/auth/forgotPassword";
  static const String verifyResetCodeEndPoint = "/auth/verifyResetCode";
  static const String resetPasswordEndPoint = "/auth/resetPassword";
  static const String deleteMyAccountEndPoint = "/auth/deleteMe";
  static const String profileDataEndPoint = "/auth/profileData";
  static const String updateProfileEndPoint = "/auth/updateProfile";
  static const String changePasswordEndPoint = "/auth/changePassword";
  static const String getAllQuestionsOnExamEndPoint = "/questions";
}
