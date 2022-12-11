import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';

InputDecoration inputDecorationForm(String labelText,
    {IconButton? iconButton, String? hintText, TextStyle? errorStyle}) {
  return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      hoverColor: ThemeColor.sand,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      errorStyle: errorStyle,
      suffixIcon: iconButton);
}
