import 'package:flutter/material.dart';

class CSSelectMethod extends StatelessWidget {
  const CSSelectMethod({
    super.key,
    this.onPressed,
    required this.title,
    required this.selectText,
  });

  final VoidCallback? onPressed;
  final String title;
  final String selectText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Spacer(),
        GestureDetector(
          onTap: onPressed,
          child: Text(selectText, style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}