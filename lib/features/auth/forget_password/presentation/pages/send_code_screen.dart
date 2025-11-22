import 'package:exam_app/core/localization/l10n/app_localizations.dart';

import '../../../../../core/config/validation/app_validation.dart';
import '../../../../../core/shared/presentation/widgets/app_button.dart';
import '../../../../../core/shared/presentation/widgets/custom_text_feild.dart';
import '../bloc/forget_password_bloc.dart';
import '../widgets/description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendCodeScreen extends StatefulWidget {
  const SendCodeScreen({super.key});
  @override
  State<SendCodeScreen> createState() => _SendCodeScreenState();
}

class _SendCodeScreenState extends State<SendCodeScreen> {
  late AppLocalizations local;
  late GlobalKey<FormState> _formkey;
  late TextEditingController emailController;
  bool isDisabled = false;

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
    local = AppLocalizations.of(context)!;

    return Form(
      key: _formkey,
      child: Center(
        child: Column(
          children: [
          const  SizedBox(height: 40),
            Description(
              title: local.forgetPasswordTitle,
              description: local.forgetPasswordDescription,
            ),
          const  SizedBox(height: 32),
            CustomTextField(
              label: local.emailLabel,
              hint: local.emailHint,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => Validators.emailValidator(val),
              onChanged: (val) {
                if (Validators.emailValidator(val) == null) {
                  setState(() {
                    isDisabled = false;
                    _formkey.currentState!.validate();
                  });
                }
              },
              textFieldController: emailController,
            ),
           const SizedBox(height: 48),
            AppButton(
              title: local.continueButton,
              isDisabled: isDisabled,
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  context.read<ForgetPasswordBloc>().add(
                    SendResetCodeEvent(email: emailController.text),
                  );
                } else {
                  setState(() {
                    isDisabled = true;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
