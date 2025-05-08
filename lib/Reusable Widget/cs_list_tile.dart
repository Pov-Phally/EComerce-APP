import 'package:flutter/material.dart';

class CSListTile extends StatelessWidget {
  const CSListTile({
    super.key,  this.onTap, required this.leading, required this.title, required this.subtitle, this.trailing,
  });
  final VoidCallback? onTap;
  final Widget leading;
  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading:leading,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: trailing,
    );

  }
}