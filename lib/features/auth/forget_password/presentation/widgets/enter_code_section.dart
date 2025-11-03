import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/forget_password_bloc.dart';
import 'enter_code_widget.dart';

class EnterCodeSection extends StatefulWidget {
  const EnterCodeSection({super.key});

  @override
  State<EnterCodeSection> createState() => _EnterCodeSectionState();
}

class _EnterCodeSectionState extends State<EnterCodeSection> {
  final int _codeLength = 6;
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _focusNodes = List.generate(_codeLength, (_) => FocusNode());
    _controllers = List.generate(_codeLength, (_) => TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void onChange(String value, int index) {
    if (value.isNotEmpty && index == _codeLength - 1) {
      FocusScope.of(context).unfocus();
      String code = '';
      for (var e in _controllers) {
        code += e.text;
      }
      log(code);
      BlocProvider.of<ForgetPasswordBloc>(context).add(VerifyCodeEvent(code: code));
    } else if (value.isNotEmpty && index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_codeLength, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: EnterCodeWidget(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              onChange: (value) => onChange(value, index),
            ),
          );
        }),
      ),
    );
  }
}
