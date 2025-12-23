import 'package:flutter/material.dart';

class CSTextFormField extends StatelessWidget {
  final String label;
  final bool? readOnly;
  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;
  final  int? maxLine;
      const CSTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.onFieldSubmitted,
    this.maxLine,  this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        label: Text(label),
        hintText: hintText,
      ),
      maxLines: maxLine,
      onSubmitted: onFieldSubmitted,
      readOnly:  readOnly ?? false,
    );

  }
}