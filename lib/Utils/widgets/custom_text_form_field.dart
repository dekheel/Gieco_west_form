import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {this.inputType,
      this.labelText,
      required this.controller,
      this.onChanged,
      this.validator,
      this.obscureText,
      this.maxLine,
      this.suffixIcon,
      this.isReadOnly,
      this.textAlign,
      this.prefixIcon,
      this.hintText,
      this.onTap,
      this.action,
      super.key});

  final String? labelText;
  final bool? isReadOnly;

  TextEditingController controller;
  final TextInputType? inputType;
  final void Function(String)? onChanged;
  final int? maxLine;
  final TextAlign? textAlign;
  String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  bool? obscureText;
  final String? hintText;
  final TextInputAction? action;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onTap: onTap,
      readOnly: isReadOnly ?? false,
      textAlign: textAlign ?? TextAlign.right,
      maxLines: maxLine ?? 1,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon,
        labelText: labelText,
        hintText: hintText,
        filled: false,
        suffixIcon: suffixIcon == null
            ? null
            : IconButton(
                onPressed: onTap,
                icon: suffixIcon!,
              ),
      ),
      controller: controller,
      textInputAction: action ?? TextInputAction.next,
      keyboardType: inputType ?? TextInputType.text,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
