import 'package:flutter/material.dart';

void showAlert(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 450),
      behavior: SnackBarBehavior.floating,
    ),
  );
}