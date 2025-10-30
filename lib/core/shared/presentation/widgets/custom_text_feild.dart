import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.obscureText = false,
    required this.label,
    this.textFieldController,
    this.focusNode,
    this.keyboardType,
    this.width,
    required this.hint,
    this.validator,
  });
  final String? Function(String? val)? validator;
  final bool obscureText;
  final String label;
  final String hint;
  final TextEditingController? textFieldController;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final double? width;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        style: textTheme.bodyLarge!.copyWith(color: AppColors.blackBase),
        obscureText: widget.obscureText,
        controller: widget.textFieldController,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        cursorColor: AppColors.blueBase,
        validator: widget.validator,

        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          hint: Text(widget.hint, style: textTheme.bodyLarge),
          labelText: widget.label,
          constraints: BoxConstraints(minHeight: 56, maxWidth: 343),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: WidgetStateTextStyle.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return textTheme.bodyLarge!.copyWith(color: AppColors.blueBase);
            } else if (states.contains(WidgetState.error)) {
              return textTheme.bodyLarge!.copyWith(color: AppColors.error);
            }
            return textTheme.bodyLarge!.copyWith(color: AppColors.gray);
          }),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: AppColors.error, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: AppColors.blueBase, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: AppColors.gray, width: 1),
          ),
        ),
      ),
    );
  }
}
