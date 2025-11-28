import 'package:flutter/material.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({super.key});

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 75),
          child: Text(
            "Monify",
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.w900,
              fontSize: 35,
            ),
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/appinfo.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
