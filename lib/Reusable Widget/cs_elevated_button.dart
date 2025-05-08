import 'package:flutter/material.dart';

class CSElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;

  const CSElevatedButton({super.key, required this.text, this.onPressed, this.padding,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.deepPurpleAccent),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}