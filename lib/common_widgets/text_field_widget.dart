import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? validatorMessage;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final bool readOnly;
  final bool obscureText;
  final int? maxLines;

  const TextFormFieldWidget({
    super.key,
    this.controller,
    required this.labelText,
    this.validatorMessage,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.obscureText = false,  this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 14),
        // Adjust label font size
        errorStyle: const TextStyle(fontSize: 12),
      ),
      validator: (value) {
        if (validatorMessage != null) {
          // If a message is provided, use it directly as the validation error
          return value!.isEmpty ? validatorMessage : null;
        } else {
          // If no message is provided, use a default message
          return value!.isEmpty ? 'Please enter a valid value' : null;
        }
      },
      style: const TextStyle(fontSize: 14),
      readOnly: readOnly,
      onChanged: onChanged,
      onTap: onTap,// Adjust font size
    );
  }
}
