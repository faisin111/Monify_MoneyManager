import 'package:flutter/material.dart';

class Expence extends StatelessWidget {
  final IconData iconss;
  final String tittle;
  final String trailing;
  final Color colortral;
  const Expence({
    super.key,
    required this.iconss,
    required this.tittle,
    required this.trailing,
    required this.colortral,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(21, 20, 21, 0),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              radius: 33,
              backgroundColor: const Color.fromARGB(255, 42, 42, 42),
              child: Icon(iconss, color: Colors.yellow),
            ),
            title: Text(
              tittle,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            trailing: Text(
              trailing,
              style: TextStyle(
                fontSize: 23,
                color: colortral,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
