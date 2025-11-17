import 'dart:async';
import 'package:flutter/material.dart';
import 'package:money_manager/screens/bottomnav.dart';
import 'package:money_manager/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<bool> checkLoginn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLogin') ?? false;
  }

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () async {
      bool islogggin = await checkLoginn();
      if (islogggin == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomApp()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
