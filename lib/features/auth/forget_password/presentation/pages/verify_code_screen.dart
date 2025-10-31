import 'package:exam_app/features/auth/forget_password/presentation/bloc/forget_password_bloc.dart';
import 'package:exam_app/features/auth/forget_password/presentation/widgets/description.dart';
import 'package:exam_app/features/auth/forget_password/presentation/widgets/enter_code_section.dart';
import 'package:exam_app/features/auth/forget_password/presentation/widgets/resend_code_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});
  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 40),
          Description(
            title: "Verification Code",
            description:
                "Please enter the verification code sent to your email",
          ),
          SizedBox(height: 32),
          EnterCodeSection(),
          ResendCodeSection(
            message: "Didn't receive the code?",
            buttonTitle: "Resend",
            onTap: () => context.read<ForgetPasswordBloc>().add(
              SendResetCodeEvent(
                email: context.read<ForgetPasswordBloc>().email,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
