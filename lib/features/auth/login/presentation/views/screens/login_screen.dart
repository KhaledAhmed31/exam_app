import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/config/utils/dialog_utils.dart';
import 'package:exam_app/core/config/validation/app_validation.dart';
import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/core/shared/presentation/ui_strings/ui_strings.dart';
import 'package:exam_app/core/shared/presentation/widgets/app_button.dart';
import 'package:exam_app/core/shared/presentation/widgets/custom_text_feild.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_states.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthViewModel viewModel = getIt<AuthViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.black,
          ),
          onPressed: () {},
        ),
        title: Text(
          UiStrings.login,
          style: FontStyleManager.interMedium(
            color: AppColors.black,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider<AuthViewModel>(
          create: (context) => viewModel,
          child: Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                SizedBox(height: 14),
                CustomTextField(
                  onChanged: viewModel.onEmailChange,
                  validator: (val) => Validators.emailValidator(val),
                  label: UiStrings.emailLabel,
                  hintText: UiStrings.emailHintText,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 24),
                CustomTextField(
                  onChanged: viewModel.onPasswordChange,
                  validator: (val) => Validators.passwordValidator(val),
                  label: UiStrings.passwordLabel,
                  hintText: UiStrings.passwordHintText,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                Row(
                  children: [
                    SizedBox(width: 20),
                    BlocBuilder<AuthViewModel, AuthStates>(
                      builder: (BuildContext context, AuthStates state) {
                        return Checkbox(
                          checkColor: AppColors.white,
                          fillColor: viewModel.rememberMe
                              ? WidgetStateProperty.all(AppColors.gray)
                              : WidgetStateProperty.all(Colors.transparent),
                          value: viewModel.rememberMe,
                          onChanged: (value) {
                            viewModel.changeRememberMe(value);
                          },
                        );
                      },
                    ),
                    Text(
                      UiStrings.rememberMe,
                      style: FontStyleManager.interRegular(
                        color: AppColors.blackBase,
                        fontSize: FontSizesManager.s14,
                      ),
                    ),
                    Spacer(),
                    Text.rich(
                      TextSpan(
                        text: UiStrings.forgetPassword,
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
                BlocConsumer<AuthViewModel, AuthStates>(
                  builder: (context, state) {
                    return AppButton(
                      isDisabled: viewModel.isLoginButtonDisabled(),
                      title: UiStrings.login,
                      onPressed: () {
                        viewModel.login();
                      },
                    );
                  },
                  listener: (context, state) {
                    if (state is LoginLoadingState) {
                      DialogUtils.showLoading(
                        context,
                        state.loadingMessage,
                        AppColors.white,
                      );
                    } else if (state is LoginSuccessState) {
                      DialogUtils.hideLoading(context);
                      DialogUtils.showMessage(
                        context,
                        state.data?.userModel?.firstName ?? "",
                        titleMessage: 'Success',
                        backgroundColor: AppColors.blueBase,
                        textColor: AppColors.white,
                        posActionName: 'OK',
                        actionColor: AppColors.white,
                        posAction: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutePath.home,
                          );
                        },
                      );
                    } else if (state is LoginErrorState) {
                      DialogUtils.hideLoading(context);
                      DialogUtils.showMessage(
                        context,
                        state.errorMessage,
                        titleMessage: 'Error',
                        backgroundColor: AppColors.blueBase,
                        textColor: AppColors.white,
                        negActionName: 'OK',
                        actionColor: AppColors.white,
                      );
                    }
                  },
                ),
                SizedBox(height: 16),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: UiStrings.doNotHaveAccount,
                      style: FontStyleManager.interRegular(
                        color: AppColors.blackBase,
                        fontSize: FontSizesManager.s16,
                      ),
                      children: [
                        TextSpan(
                          text: UiStrings.signUp,
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
          ),
        ),
      ),
    );
  }
}
