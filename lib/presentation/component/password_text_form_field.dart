import 'package:flutter/material.dart';

class CustomPasswordTextFormField extends StatelessWidget {
  final String initialValue;
  final Widget sufflixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final void Function(String) onChanged;

  const CustomPasswordTextFormField({
    super.key,
    required this.sufflixIcon,
    required this.initialValue,
    this.validator,
    required this.obscureText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: 'Password',
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12.0,
          ),
          suffixIcon: sufflixIcon,
        ),
        validator: validator,
        obscureText: obscureText,
        onChanged: onChanged);
  }
}
