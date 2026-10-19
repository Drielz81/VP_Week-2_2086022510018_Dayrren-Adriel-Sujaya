import 'package:flutter/material.dart';
import 'package:week2/core/theme/app_theme.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.hintText,
    this.isObscureText = false,
    required this.controller,
  });

  final String hintText;
  final bool isObscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppTheme.whiteColor
        )),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is Missing';
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}
