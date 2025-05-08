import 'package:flutter/material.dart';

void alert(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(message)),
      duration: Duration(milliseconds: 550),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
  );
}