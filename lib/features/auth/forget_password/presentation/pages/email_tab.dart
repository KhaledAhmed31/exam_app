import 'package:exam_app/core/config/validation/app_validation.dart';
import 'package:exam_app/core/shared/presentation/widgets/app_button.dart';
import 'package:exam_app/core/shared/presentation/widgets/custom_text_feild.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/auth/forget_password/presentation/bloc/forget_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EmailTab extends StatefulWidget {
  const EmailTab({super.key, required this.pageController});
  final PageController pageController;
  @override
  State<EmailTab> createState() => _EmailTabState();
}

class _EmailTabState extends State<EmailTab> {
  late GlobalKey<FormState> _formkey;
  late TextEditingController emailController;
  @override
  void initState() {
    _formkey = GlobalKey<FormState>();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          context.loaderOverlay.show();
        } else if (state is ForgetPasswordError) {
          context.loaderOverlay.hide();
          Fluttertoast.showToast(
            msg: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: AppColors.blueBase,
            textColor: AppColors.white,
            fontSize: 16.0,
          );
        } else if (state is ForgetPasswordSuccess) {
          context.loaderOverlay.hide();
          widget.pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        }
      },
      child: Form(
        key: _formkey,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                "Forget password",
                style: FontStyleManager.interMedium(
                  fontSize: FontSizesManager.s18,
                  color: AppColors.blackBase,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 275),
                child: Text(
                  "Please enter your email associated to your account",
                  style: FontStyleManager.interRegular(
                    fontSize: FontSizesManager.s14,
                    color: AppColors.gray,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 32),
              CustomTextField(
                label: "Email",
                hint: "Enter your email",
                keyboardType: TextInputType.emailAddress,
                validator: (val) => Validators.emailValidator(val),
                textFieldController: emailController,
              ),
              SizedBox(height: 48),
              AppButton(
                title: "Continue",
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    context.read<ForgetPasswordBloc>().add(
                      SendResetCodeEvent(email: emailController.text),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
