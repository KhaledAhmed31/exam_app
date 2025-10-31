import 'package:exam_app/core/config/validation/app_validation.dart';
import 'package:exam_app/core/shared/presentation/widgets/app_button.dart';
import 'package:exam_app/core/shared/presentation/widgets/custom_text_feild.dart';
import 'package:exam_app/features/auth/forget_password/presentation/bloc/forget_password_bloc.dart';
import 'package:exam_app/features/auth/forget_password/presentation/widgets/description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendCodeScreen extends StatefulWidget {
  const SendCodeScreen({super.key});
  @override
  State<SendCodeScreen> createState() => _SendCodeScreenState();
}

class _SendCodeScreenState extends State<SendCodeScreen> {
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
    return Form(
      key: _formkey,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            Description(
              title: "Forgot Password",
              description:
                  "Please enter your email associated to your account",
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
    );
  }
}
