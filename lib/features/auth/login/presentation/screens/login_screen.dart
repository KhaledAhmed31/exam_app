import '../../../../../core/config/utils/dialog_utils.dart';
import '../../../../../core/config/validation/app_validation.dart';
import '../../../../../core/localization/l10n/app_localizations.dart';
import '../../../../../core/routes/route_path.dart';
import '../../../../../core/shared/presentation/widgets/app_button.dart';
import '../../../../../core/shared/presentation/widgets/custom_text_feild.dart';
import '../../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../../core/ui_manager/fonts/font_sizes_manager.dart';
import '../../../../../core/ui_manager/fonts/font_style_manager.dart';
import '../bloc/auth_events.dart';
import '../bloc/auth_states.dart';
import '../bloc/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new_outlined,
        //     color: AppColors.black,
        //   ),
        //   onPressed: () {},
        // ),
        title: Text(
          local.loginTitle,
          style: FontStyleManager.interMedium(
            color: AppColors.black,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<AuthViewModel, AuthStates>(
          listener: (context, state) {
            if (state.loginState?.isLoading == true) {
              DialogUtils.showLoading(
                context,
                local.loadingTitle,
                AppColors.white,
              );
            } else if (state.loginState?.isLoading == false &&
                state.loginState?.data != null) {
              DialogUtils.hideLoading(context);
              DialogUtils.showMessage(
                context,
                state.loginState?.data?.userModel?.firstName ?? "",
                titleMessage: local.successTitle,
                backgroundColor: AppColors.blueBase,
                textColor: AppColors.white,
                posActionName: local.ok,
                actionColor: AppColors.white,
                posAction: () {
                  Navigator.pushReplacementNamed(context, RoutePath.home);
                },
              );
            } else if (state.loginState?.errorMessage?.isNotEmpty == true) {
              DialogUtils.hideLoading(context);
              DialogUtils.showMessage(
                context,
                state.loginState?.errorMessage ?? "",
                titleMessage: local.errorTitle,
                backgroundColor: AppColors.blueBase,
                textColor: AppColors.white,
                negActionName: local.ok,
                actionColor: AppColors.white,
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: BlocProvider.of<AuthViewModel>(context).formKey,
              child: Column(
                children: [
                  SizedBox(height: 14),
                  CustomTextField(
                    onChanged: (val) {
                      BlocProvider.of<AuthViewModel>(
                        context,
                      ).add(EmailOnChangedEvent(val));
                    },
                    validator: (val) => Validators.emailValidator(val),
                    label: local.emailLabel,
                    hint: local.emailHint,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),
                  CustomTextField(
                    onChanged: (val) {
                      BlocProvider.of<AuthViewModel>(
                        context,
                      ).add(PasswordOnChangedEvent(val));
                    },
                    validator: (val) => Validators.passwordValidator(val),
                    label: local.forgetPasswordScreenTitle,
                    hint: local.passwordHint,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Checkbox(
                        checkColor: AppColors.white,
                        fillColor:
                            BlocProvider.of<AuthViewModel>(context).rememberMe
                            ? WidgetStateProperty.all(AppColors.grey)
                            : WidgetStateProperty.all(Colors.transparent),
                        value: BlocProvider.of<AuthViewModel>(
                          context,
                        ).rememberMe,
                        onChanged: (value) {
                          BlocProvider.of<AuthViewModel>(
                            context,
                          ).add(ChangeRememberMeEvent(value));
                        },
                      ),
                      Text(
                        local.rememberMeTitle,
                        style: FontStyleManager.interRegular(
                          color: AppColors.blackBase,
                          fontSize: FontSizesManager.s14,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RoutePath.forgetPassword,
                          );
                        },
                        child: Text(
                          local.forgetPasswordTitle,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: FontSizesManager.s14,
                            color: AppColors.blackBase,
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                    ],
                  ),
                  SizedBox(height: 48),
                  AppButton(
                    isDisabled:
                        !(Validators.emailValidator(
                                  BlocProvider.of<AuthViewModel>(context).email,
                                ) ==
                                null &&
                            Validators.passwordValidator(
                                  BlocProvider.of<AuthViewModel>(
                                    context,
                                  ).password,
                                ) ==
                                null),
                    title: local.loginTitle,
                    onPressed: () {
                      BlocProvider.of<AuthViewModel>(
                        context,
                      ).add(LoginEvents());
                    },
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: local.doNotHaveAccount,
                        style: FontStyleManager.interRegular(
                          color: AppColors.blackBase,
                          fontSize: FontSizesManager.s16,
                        ),
                        children: [
                          TextSpan(
                            text: local.signUpTitle,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.blueBase,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSizesManager.s16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
