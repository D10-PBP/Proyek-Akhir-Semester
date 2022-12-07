import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/style.dart';

class TextFormFieldAuth extends StatelessWidget {
  const TextFormFieldAuth(
      {super.key,
      required this.placeholder,
      required this.setFieldState,
      this.validator,
      this.iconButton,
      this.obscureText = false,
      this.hintText,
      this.errorStyle});

  final String placeholder;
  final dynamic setFieldState;
  final dynamic validator;
  final IconButton? iconButton;
  final bool obscureText;
  final String? hintText;
  final TextStyle? errorStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        style: const TextStyle(fontFamily: "PlusJakarta'", fontSize: 15),
        decoration: inputDecorationForm(placeholder,
            iconButton: iconButton, hintText: hintText, errorStyle: errorStyle),
        onChanged: setFieldState,
        onSaved: setFieldState,
        validator: validator);
    ;
  }
}
