import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilledTextField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final Widget prefixIcon;

  const FilledTextField({
    required this.hintText,
    this.errorText = '',
    required this.onChanged,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autocorrect: false,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Theme.of(context).accentColor),
      decoration: InputDecoration(
          errorText: errorText, hintText: hintText, prefixIcon: prefixIcon),
    );
  }
}
