import '../../../../../core/localization/l10n/app_localizations.dart';

import '../bloc/forget_password_bloc.dart';
import '../widgets/description.dart';
import '../widgets/enter_code_section.dart';
import '../widgets/resend_code_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});
  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  late AppLocalizations local;
  
  @override
  Widget build(BuildContext context) {
    local = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        children: [
          SizedBox(height: 40),
          Description(
            title: local.verifyCodeTitle,
            description:
                local.verifyCodeDescription,
          ),
          SizedBox(height: 32),
          EnterCodeSection(),
          SizedBox(height: 24),
          ResendCodeSection(
            message: local.doNotReceiveCode,
            buttonTitle: local.resendCode,
            onTap: () => context.read<ForgetPasswordBloc>().add(
              ResendResetCodeEvent(
                email: context.read<ForgetPasswordBloc>().email,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
