import 'package:flutter/material.dart';

class Customtile extends StatelessWidget {
  final String text;
  final IconButton? trailing;
  const Customtile({super.key, required this.text, this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        text,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
      trailing: trailing,
    );
  }
}
