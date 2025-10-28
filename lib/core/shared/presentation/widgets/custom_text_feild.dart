import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.obscureText = false,
    required this.label,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.width,
  });
  final bool obscureText;
  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final double? width;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextTheme textTheme;
  bool isFocused = false;
  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: widget.width,
      child: TextField(
        style: textTheme.bodyLarge!.copyWith(color: AppColors.blackBase),
        obscureText: widget.obscureText,
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        cursorColor: AppColors.blueBase,
        onTap: () => setState(() {
          isFocused = true;
        }),
        onTapOutside: (event) {
          isFocused = false;
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          hint: Text(widget.label, style: textTheme.bodyLarge),
          labelText: widget.label,
          constraints: BoxConstraints(minHeight: 56, maxWidth: 343),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: textTheme.bodySmall!.copyWith(
            color: isFocused ? AppColors.blueBase : AppColors.gray,
          ),
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
