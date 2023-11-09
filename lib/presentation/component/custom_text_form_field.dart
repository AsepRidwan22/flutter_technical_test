import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.initialValue,
    this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12.0,
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
