import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/style.dart';

class TextFormFieldAuth extends StatelessWidget {
  const TextFormFieldAuth(
      {super.key,
      required this.placeholder,
      this.setFieldState,
      this.validator,
      this.iconButton,
      this.obscureText = false,
      this.hintText,
      this.errorStyle,
      this.numberOnly = false,
      this.initialValue,
      this.enabled = true});

  final String placeholder;
  final dynamic setFieldState;
  final dynamic validator;
  final IconButton? iconButton;
  final bool obscureText;
  final String? hintText;
  final TextStyle? errorStyle;
  final bool numberOnly;

  final String? initialValue;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: (numberOnly) ? TextInputType.number : null,
      inputFormatters: (numberOnly)
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      obscureText: obscureText,
      style: const TextStyle(fontFamily: "PlusJakarta'", fontSize: 15),
      decoration: inputDecorationForm(placeholder,
          iconButton: iconButton, hintText: hintText, errorStyle: errorStyle),
      onChanged: setFieldState,
      onSaved: setFieldState,
      validator: validator,
      enabled: enabled,
      initialValue: initialValue,
    );
  }
}
