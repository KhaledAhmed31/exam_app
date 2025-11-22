import '../../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../../core/ui_manager/fonts/font_sizes_manager.dart';
import '../../../../../core/ui_manager/fonts/font_style_manager.dart';
import 'package:flutter/material.dart';

class EnterCodeWidget extends StatefulWidget {
  const EnterCodeWidget({
    super.key,
    required this.focusNode,
    required this.controller,
    this.onChange,
  });
  final FocusNode focusNode;
  final TextEditingController controller;
  final void Function(String value)? onChange;
  @override
  State<EnterCodeWidget> createState() => _EnterCodeWidgetState();
}

class _EnterCodeWidgetState extends State<EnterCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 60,

      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        textAlign: TextAlign.center,
        showCursor: false,
        canRequestFocus: true,
        enableInteractiveSelection: false,
        keyboardType: TextInputType.number,
        onChanged: widget.onChange,
        maxLength: 1,
        validator: (value) => value!.isEmpty ? '' : null,
        decoration: InputDecoration(
          counterText: '',
          fillColor: AppColors.blue10,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        style: FontStyleManager.robotoMedium(
          fontSize: FontSizesManager.s16,
          color: AppColors.blackBase,
        ),
      ),
    );
  }
}
