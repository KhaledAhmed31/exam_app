import 'package:exam_app/core/config/validation/app_validation.dart';
import 'package:exam_app/core/shared/presentation/widgets/app_button.dart';
import 'package:exam_app/core/shared/presentation/widgets/custom_text_feild.dart';
import 'package:exam_app/features/auth/forget_password/presentation/bloc/forget_password_bloc.dart';
import 'package:exam_app/features/auth/forget_password/presentation/widgets/description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late GlobalKey<FormState> _formkey;
  late TextEditingController confirmPassowrdController;
  late TextEditingController passwordController;
  @override
  void initState() {
    _formkey = GlobalKey<FormState>();
    passwordController = TextEditingController();
    confirmPassowrdController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPassowrdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            Description(
              title: "Forgot Password",
              description: "Please enter your email associated to your account",
            ),

            SizedBox(height: 32),
            CustomTextField(
              label: "New password",
              hint: "Enter your password",
              keyboardType: TextInputType.emailAddress,
              validator: (val) => Validators.passwordValidator(val),
              textFieldController: passwordController,
            ),
            SizedBox(height: 24),
            CustomTextField(
              label: "Confirm password",
              hint: "Confirm password",
              keyboardType: TextInputType.emailAddress,
              validator: (val) => Validators.passwordValidator(val),
              textFieldController: confirmPassowrdController,
            ),
            SizedBox(height: 48),
            AppButton(
              title: "Continue",
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  if (passwordController.text ==
                      confirmPassowrdController.text) {
                    context.read<ForgetPasswordBloc>().add(
                      ResetPasswordEvent(
                        email: context.read<ForgetPasswordBloc>().email,
                        password: passwordController.text,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
