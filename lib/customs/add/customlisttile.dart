import 'package:flutter/material.dart';

class CustomListtile extends StatelessWidget {
  final String leading;
  final String values;
  const CustomListtile({
    super.key,
    required this.leading,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        leading,
        style: TextStyle(
          color: const Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w500,
          fontSize: 25,
        ),
      ),
      title: Text(
        ':',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        values,
        style: TextStyle(
          color: const Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w500,
          fontSize: 25,
        ),
      ),
    );
  }
}
