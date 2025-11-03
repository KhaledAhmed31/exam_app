import 'package:exam_app/core/localization/l10n/app_localizations.dart';

import '../../../../../core/config/validation/app_validation.dart';
import '../../../../../core/shared/presentation/widgets/app_button.dart';
import '../../../../../core/shared/presentation/widgets/custom_text_feild.dart';
import '../bloc/forget_password_bloc.dart';
import '../widgets/description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late AppLocalizations local;
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
    local = AppLocalizations.of(context)!;

    return Form(
      key: _formkey,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            Description(
              title: local.resetPasswordTitle,
              description: local.resetPasswordDescription,
            ),

            SizedBox(height: 32),
            CustomTextField(
              label: local.passwordLabel,
              hint: local.passwordHint,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => Validators.passwordValidator(val),
              textFieldController: passwordController,
            ),
            SizedBox(height: 24),
            CustomTextField(
              label: local.confirmPassowrdLabel,
              hint: local.confirmPasswordHint,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => Validators.confirmPasswordValidator(
                val,
                passwordController.text,
              ),
              textFieldController: confirmPassowrdController,
            ),
            SizedBox(height: 48),
            AppButton(
              title: local.continueButton,
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
