import 'package:flutter/material.dart';

class CSTextFormField extends StatelessWidget {
  const CSTextFormField({
    super.key,
    required this.label,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.hintText,
    this.obscureText,
    this.suffixIcon,
  });
  final String label;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool? obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: prefixIcon,
        label: Text(label, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 12),
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText ?? false,
    );
  }
}